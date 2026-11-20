import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required Color couleur,
    required String titre,
    required String valeur,
    required String messageSnackBar,
  }) {
    return Card(
      elevation: 4,
      shadowColor: couleur.withValues(alpha: 0.2),
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: couleur.withValues(alpha: 0.25)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: couleur.withValues(alpha: 0.14),
          child: Icon(icon, color: couleur, size: 24),
        ),
        title: Text(
          titre,
          style: TextStyle(fontWeight: FontWeight.bold, color: couleur, fontSize: 15),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            valeur,
            style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14),
          ),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: couleur),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: couleur,
              content: Text(messageSnackBar),
            ),
          );
        },
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
            Color(0xFFE0F2FE),
            Color(0xFFF8FAFC),
          ],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 18),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F766E), Color(0xFF0284C7), Color(0xFF4F46E5)],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                Icon(Icons.contact_mail_rounded, size: 42, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  'Mes coordonnées',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Appuyez sur une carte pour voir les détails de contact.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFFE0F2FE), fontSize: 13.5),
                ),
              ],
            ),
          ),
          _buildContactCard(
            context: context,
            icon: Icons.location_on_rounded,
            couleur: const Color(0xFF0284C7),
            titre: 'Adresse',
            valeur: 'Quartier Kyeshero, Goma, Nord-Kivu, RDC',
            messageSnackBar: 'Adresse : Quartier Kyeshero, Goma, Nord-Kivu, RDC',
          ),
          _buildContactCard(
            context: context,
            icon: Icons.phone_rounded,
            couleur: const Color(0xFF0D9488),
            titre: 'Téléphone',
            valeur: '+243972033510',
            messageSnackBar: 'Téléphone : +243972033510',
          ),
          _buildContactCard(
            context: context,
            icon: Icons.email_rounded,
            couleur: const Color(0xFF4F46E5),
            titre: 'E-mail',
            valeur: 'jemimamuhindo83@gmail.com',
            messageSnackBar: 'E-mail : jemimamuhindo83@gmail.com',
          ),
          _buildContactCard(
            context: context,
            icon: Icons.facebook_rounded,
            couleur: const Color(0xFF1877F2),
            titre: 'Facebook',
            valeur: 'Jemima Muhindo',
            messageSnackBar: 'Facebook : Jemima Muhindo',
          ),
        ],
      ),
    );
  }
}