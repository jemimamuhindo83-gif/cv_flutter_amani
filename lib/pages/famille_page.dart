import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FamillePage extends StatefulWidget {
  const FamillePage({super.key});

  @override
  State<FamillePage> createState() => _FamillePageState();
}

class _FamillePageState extends State<FamillePage> {
  static const String _baseUrl = 'http://localhost/api-test/public/famille-membres';

  List<dynamic> _membres = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _chargerMembres();
  }

  List<dynamic> _extraireListe(dynamic decoded) {
  if (decoded is List) {
    return decoded;
  }
  if (decoded is Map) {
    final data = decoded['data'];
    if (data is List) {
      return data;
    }
    final membres = decoded['membres'];
    if (membres is List) {
      return membres;
    }
  }
  return [];
}
   

  Future<void> _chargerMembres() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        final liste = _extraireListe(decoded);
        setState(() {
          _membres = liste
              .whereType()
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Erreur chargement (${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Impossible de joindre l\'API : $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _enregistrerMembre({
    Map<String, dynamic>? existant,
    required String nom,
    required String postnom,
    required String prenom,
    required String lieuNaissance,
    required String dateNaissance,
    required String parente,
    String? image,
  }) async {
    final Map<String, dynamic> payload = {
      'nom': nom.trim(),
      'postnom': postnom.trim(),
      'prenom': prenom.trim(),
      'lieu_naissance': lieuNaissance.trim(),
      'date_naissance': dateNaissance.trim(),
      'parente': parente.trim(),
      'image': (image == null || image.trim().isEmpty) ? null : image.trim(),
    };

    final bool estModification = existant != null && existant['id'] != null;
    final Uri uri = estModification
        ? Uri.parse('$_baseUrl/${existant['id']}')
        : Uri.parse(_baseUrl);

    final http.Response response = estModification
        ? await http.put(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(payload),
          )
        : await http.post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(payload),
          );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      await _chargerMembres();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            estModification
                ? 'Membre modifié avec succès'
                : 'Membre ajouté avec succès',
          ),
        ),
      );
    } else {
      String msg = 'Échec de l\'opération (${response.statusCode})';
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map && decoded['message'] != null) {
          msg = decoded['message'].toString();
        }
      } catch (_) {}
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  Future<void> _supprimerMembre(Map<String, dynamic> membre) async {
    final id = membre['id'];
    if (id == null) return;

    final bool? confirme = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: Text(
          'Supprimer ${membre['prenom'] ?? ''} ${membre['nom'] ?? ''} ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirme != true) return;

    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        await _chargerMembres();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Membre supprimé')),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur suppression (${response.statusCode})')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur réseau : $e')),
      );
    }
  }

  Widget _construireAvatar(Map<String, dynamic> membre) {
    final String img = (membre['image'] ?? '').toString().trim();
    final String initiale = (membre['prenom']?.toString().isNotEmpty == true
            ? membre['prenom'].toString()[0]
            : (membre['nom']?.toString().isNotEmpty == true
                ? membre['nom'].toString()[0]
                : '?'))
        .toUpperCase();

    if (img.startsWith('assets/')) {
      return CircleAvatar(
        backgroundImage: AssetImage(img),
        onBackgroundImageError: (_, __) {},
        child: null,
      );
    }

    if (img.startsWith('http://') || img.startsWith('https://')) {
      return CircleAvatar(
        backgroundImage: NetworkImage(img),
        onBackgroundImageError: (_, __) {},
        child: null,
      );
    }

    return CircleAvatar(child: Text(initiale));
  }

  void _ouvrirFormulaireMembre({Map<String, dynamic>? existant}) {
    final formKey = GlobalKey<FormState>();
    final nomCtrl =
        TextEditingController(text: existant?['nom']?.toString() ?? '');
    final postnomCtrl =
        TextEditingController(text: existant?['postnom']?.toString() ?? '');
    final prenomCtrl =
        TextEditingController(text: existant?['prenom']?.toString() ?? '');
    final lieuCtrl = TextEditingController(
      text: existant?['lieu_naissance']?.toString() ?? '',
    );
    final dateCtrl = TextEditingController(
      text: existant?['date_naissance']?.toString() ?? '1995-01-01',
    );
    final parenteCtrl = TextEditingController(
      text: existant?['parente']?.toString() ?? '',
    );
    final imageCtrl =
        TextEditingController(text: existant?['image']?.toString() ?? '');

    bool saving = false;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(
            existant == null ? 'Ajouter un membre' : 'Modifier le membre',
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nomCtrl,
                    decoration: const InputDecoration(labelText: 'Nom *'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: postnomCtrl,
                    decoration: const InputDecoration(labelText: 'Postnom *'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: prenomCtrl,
                    decoration: const InputDecoration(labelText: 'Prénom *'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: parenteCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Parenté (ex. Père, Mère, Frère, Sœur) *',
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: lieuCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Lieu de naissance *'),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Champ requis' : null,
                  ),
                  TextFormField(
                    controller: dateCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Date de naissance (YYYY-MM-DD) *',
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return 'Champ requis';
                      final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                      if (!regex.hasMatch(v.trim())) {
                        return 'Format attendu : AAAA-MM-JJ';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: imageCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Image (ex. assets/images/papa.jpg.jpeg)',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: saving ? null : () => Navigator.pop(ctx),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: saving
                  ? null
                  : () async {
                      if (!formKey.currentState!.validate()) return;
                      setDialogState(() => saving = true);
                      await _enregistrerMembre(
                        existant: existant,
                        nom: nomCtrl.text,
                        postnom: postnomCtrl.text,
                        prenom: prenomCtrl.text,
                        lieuNaissance: lieuCtrl.text,
                        dateNaissance: dateCtrl.text,
                        parente: parenteCtrl.text,
                        image: imageCtrl.text,
                      );
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
              child: Text(saving ? 'Enregistrement...' : 'Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Famille'),
        actions: [
          IconButton(
            onPressed: _chargerMembres,
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualiser',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _ouvrirFormulaireMembre(),
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _errorMessage!,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _chargerMembres,
                          child: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),
                )
              : _membres.isEmpty
                  ? const Center(
                      child: Text(
                        'Aucun membre enregistré. Cliquez sur "Ajouter".',
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _membres.length,
                      itemBuilder: (context, index) {
                        final m = _membres[index];
                        final titre =
                            '${m['prenom'] ?? ''} ${m['nom'] ?? ''} ${m['postnom'] ?? ''}'
                                .trim();
                        final sousTitre =
                            '${m['parente'] ?? ''} • Né(e) à ${m['lieu_naissance'] ?? ''} (${m['date_naissance'] ?? ''})';

                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: _construireAvatar(m),
                            title: Text(titre.isEmpty ? 'Membre' : titre),
                            subtitle: Text(sousTitre),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  tooltip: 'Modifier',
                                  onPressed: () =>
                                      _ouvrirFormulaireMembre(existant: m),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  tooltip: 'Supprimer',
                                  onPressed: () => _supprimerMembre(m),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}