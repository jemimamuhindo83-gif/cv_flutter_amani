import 'package:flutter/material.dart';
import 'pages/contact_page.dart';
import 'pages/cv_page.dart';
import 'pages/famille_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MonCvApp());
}

class MonCvApp extends StatelessWidget {
  const MonCvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Flutter Amani',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        useMaterial3: true,
      ),
      home: const RootNavigation(),
    );
  }
}

class RootNavigation extends StatefulWidget {
  const RootNavigation({super.key});

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  bool _estConnecte = false;
  int _indexActuel = 0;

  final List<Widget> _pages = const [
    CvPage(),
    FamillePage(),
    ContactPage(),
  ];

  final List<String> _titres = const [
    'Accueil / CV',
    'Ma Famille',
    'Contact',
  ];

  void _allerVersAppPrincipale() {
    setState(() {
      _estConnecte = true;
      _indexActuel = 0;
    });
  }

  void _seDeconnecter() {
    setState(() {
      _estConnecte = false;
      _indexActuel = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_estConnecte) {
      return LoginPage(onLoginSuccess: _allerVersAppPrincipale);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titres[_indexActuel],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF312E81),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: 'Déconnexion',
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: _seDeconnecter,
          ),
        ],
      ),
      body: _pages[_indexActuel],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexActuel,
        onDestinationSelected: (index) {
          setState(() {
            _indexActuel = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'CV',
          ),
          NavigationDestination(
            icon: Icon(Icons.family_restroom_outlined),
            selectedIcon: Icon(Icons.family_restroom),
            label: 'Famille',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_page_outlined),
            selectedIcon: Icon(Icons.contact_page),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}