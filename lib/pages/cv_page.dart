import 'package:flutter/material.dart';

class CvPage extends StatelessWidget {
  const CvPage({super.key});

  Widget _buildSectionCard({
    required IconData icon,
    required Color accentColor,
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shadowColor: accentColor.withValues(alpha: 0.2),
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: accentColor.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: accentColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
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
            Color(0xFFEEF2FF),
            Color(0xFFF8FAFC),
          ],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // En-tête héro avec dégradé, photo, nom, titre et profil
            Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF312E81),
                    Color(0xFF4F46E5),
                    Color(0xFF0284C7),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        width: 108,
                        height: 108,
                        child: Image.asset(
                          'assets/images/profil.jpg.jpeg',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFFEEF2FF),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.broken_image_rounded,
                                size: 42,
                                color: Color(0xFF4F46E5),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Amani Muhindo Jemima',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Titre : Étudiante en Informatique & Développement Mobile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profil',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFE0F2FE),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Étudiante sérieuse, curieuse et motivée, orientée vers le développement d’applications mobiles avec Flutter, la création de sites web et les réseaux informatiques.',
                          style: TextStyle(
                            color: Colors.white,
                            height: 1.45,
                            fontSize: 13.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Formation
            _buildSectionCard(
              icon: Icons.school_rounded,
              accentColor: const Color(0xFF4F46E5),
              title: 'Formation',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parcours universitaire en Informatique',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 3),
                  Text('Formation académique et travaux pratiques en informatique et génie logiciel.'),
                  SizedBox(height: 12),
                  Text(
                    'Réseaux informatiques (CCNA)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 3),
                  Text('Bases des réseaux, routage, commutation et sécurité réseau.'),
                ],
              ),
            ),

            // Expériences
            _buildSectionCard(
              icon: Icons.work_rounded,
              accentColor: const Color(0xFF0284C7),
              title: 'Expériences',
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stage professionnel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 3),
                  Text('Mise en pratique des notions acquises et rédaction d’un rapport de stage.'),
                  SizedBox(height: 12),
                  Text(
                    'Projets académiques et pratiques',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 3),
                  Text(
                    '• Développement d’applications mobiles en Flutter (avec gestion de code sur GitHub).\n'
                    '• Création et configuration de sites web.',
                    style: TextStyle(height: 1.45),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Encadrement & sensibilisation',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(height: 3),
                  Text('Initiation et accompagnement des jeunes sur l’usage responsable du numérique.'),
                ],
              ),
            ),

            // Compétences techniques
            _buildSectionCard(
              icon: Icons.code_rounded,
              accentColor: const Color(0xFF0D9488),
              title: 'Compétences techniques',
              child: const Text(
                '• Développement mobile : Flutter / Dart\n'
                '• Gestion de versions : Git & GitHub\n'
                '• Web & outils : WordPress, bureautique, gestion de fichiers\n'
                '• Réseaux : notions fondamentales de réseaux informatiques',
                style: TextStyle(height: 1.6, fontSize: 14),
              ),
            ),

            // Compétences linguistiques
            _buildSectionCard(
              icon: Icons.translate_rounded,
              accentColor: const Color(0xFF7C3AED),
              title: 'Compétences linguistiques',
              child: const Text(
                '• Français : courant (lu, écrit, parlé)\n'
                '• Anglais : niveau intermédiaire / compréhension technique\n'
                '• Swahili : courant',
                style: TextStyle(height: 1.6, fontSize: 14),
              ),
            ),

            // Centres d'intérêt
            _buildSectionCard(
              icon: Icons.auto_awesome_rounded,
              accentColor: const Color(0xFFDB2777),
              title: 'Centres d’intérêt',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildInterestChip('Développement mobile', const Color(0xFF4F46E5)),
                  _buildInterestChip('Technologies numériques', const Color(0xFF0284C7)),
                  _buildInterestChip('Apprentissage continu', const Color(0xFF0D9488)),
                  _buildInterestChip('Travail en équipe', const Color(0xFFDB2777)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildInterestChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}