import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _identifiantController = TextEditingController();
  final TextEditingController _motDePasseController = TextEditingController();
  bool _masquerMotDePasse = true;
  String? _messageErreur;
  bool _chargement = false;

  @override
  void dispose() {
    _identifiantController.dispose();
    _motDePasseController.dispose();
    super.dispose();
  }

  Future<void> _soumettre() async {
    final id = _identifiantController.text.trim();
    final mdp = _motDePasseController.text.trim();

    if (id.isEmpty || mdp.isEmpty) {
      setState(() {
        _messageErreur = 'Veuillez saisir votre identifiant (email) et votre mot de passe.';
      });
      return;
    }

    setState(() {
      _messageErreur = null;
      _chargement = true;
    });

    try {
      final uri = Uri.parse('http://localhost/api-test/public/accounts/login');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': id,
          'password': mdp,
        }),
      );

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200 && body['success'] == true) {
        setState(() {
          _chargement = false;
        });
        widget.onLoginSuccess();
      } else {
        setState(() {
          _chargement = false;
          _messageErreur = body['message']?.toString() ?? 'Email ou mot de passe incorrect.';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _chargement = false;
        _messageErreur = 'Impossible de contacter le serveur API (vérifiez XAMPP / Apache).';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E1B4B),
              Color(0xFF4338CA),
              Color(0xFF0EA5E9),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 10,
                shadowColor: Colors.black38,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock_person_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Bienvenue',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E1B4B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Connectez-vous pour accéder à mon CV, ma famille et mes contacts',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 13.5),
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _identifiantController,
                        decoration: InputDecoration(
                          labelText: 'Identifiant (Email)',
                          prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF4F46E5)),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _motDePasseController,
                        obscureText: _masquerMotDePasse,
                        onSubmitted: (_) => _chargement ? null : _soumettre(),
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          prefixIcon: const Icon(Icons.key_outlined, color: Color(0xFF4F46E5)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _masquerMotDePasse ? Icons.visibility : Icons.visibility_off,
                              color: const Color(0xFF4F46E5),
                            ),
                            onPressed: () {
                              setState(() {
                                _masquerMotDePasse = !_masquerMotDePasse;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                      if (_messageErreur != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            _messageErreur!,
                            style: const TextStyle(color: Color(0xFFB91C1C), fontSize: 13),
                          ),
                        ),
                      ],
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4F46E5), Color(0xFF0284C7)],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: _chargement ? null : _soumettre,
                            icon: _chargement
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.login_rounded),
                            label: Text(
                              _chargement ? 'Connexion...' : 'Se connecter',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}