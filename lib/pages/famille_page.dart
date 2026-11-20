import 'package:flutter/material.dart';

class MembreFamille {
  final String nom;
  final String lienParente;
  final String imagePath;
  final String roleOuInfo;
  final Color couleur;

  const MembreFamille({
    required this.nom,
    required this.lienParente,
    required this.imagePath,
    required this.roleOuInfo,
    required this.couleur,
  });
}

class FamillePage extends StatelessWidget {
  const FamillePage({super.key});

  final List<MembreFamille> _membres = const [
    MembreFamille(
      nom: 'Joseph Muhindo',
      lienParente: 'Père',
      imagePath: 'assets/images/papa.jpg.jpeg',
      roleOuInfo: 'Soutien et repère familial',
      couleur: Color(0xFF4F46E5),
    ),
    MembreFamille(
      nom: 'Furaha Muhindo',
      lienParente: 'Mère',
      imagePath: 'assets/images/maman.jpg.jpeg',
      roleOuInfo: 'Pilier et encouragement au quotidien',
      couleur: Color(0xFFDB2777),
    ),
    MembreFamille(
      nom: 'Jospin Muhindo',
      lienParente: 'Frère',
      imagePath: 'assets/images/frere.jpg.jpeg',
      roleOuInfo: 'Partage et entraide',
      couleur: Color(0xFF0284C7),
    ),
    MembreFamille(
      nom: 'Joviale Muhindo',
      lienParente: 'Sœur',
      imagePath: 'assets/images/soeur.jpg.jpeg',
      roleOuInfo: 'Complicité et soutien',
      couleur: Color(0xFF0D9488),
    ),
  ];

  Widget _buildAvatar(MembreFamille membre) {
    return Container(
      width: 76,
      height: 76,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: membre.couleur, width: 2.5),
      ),
      child: ClipOval(
        child: Image.asset(
          membre.imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: membre.couleur.withValues(alpha: 0.12),
              alignment: Alignment.center,
              child: Icon(
                Icons.broken_image_rounded,
                color: membre.couleur,
                size: 30,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFDF2F8),
            Color(0xFFF8FAFC),
          ],
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _membres.length,
        itemBuilder: (context, index) {
          final membre = _membres[index];
          return Card(
            elevation: 4,
            shadowColor: membre.couleur.withValues(alpha: 0.22),
            margin: const EdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: membre.couleur.withValues(alpha: 0.25)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  _buildAvatar(membre),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          membre.nom,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: membre.couleur.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Lien de parenté : ${membre.lienParente}',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: membre.couleur,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          membre.roleOuInfo,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
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