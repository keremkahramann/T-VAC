// ignore_for_file: library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:t_vac/widgets/analysis.dart';
import 'business_page.dart' as busi; // Business sayfası için dart dosyası
import 'school_page.dart' as school; // School sayfası için dart dosyası
import 'settings_page.dart' as settings; // Settings sayfası için dart dosyası
import '../auth/login.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Drawer kapat
    _navigateToScreen(index); // İlgili sayfaya yönlendir
  }

  void _navigateToScreen(int index) {
    late Widget screen; // Değişkeni geç tanımla

    switch (index) {
      case 0:
        screen = const MainMenu(); // Home sayfasına yönlendir
        break;
      case 1:
        screen = const busi.BusinessPage(); // Business sayfasına yönlendir
        break;
      case 2:
        screen = const school.SchoolPage(); // School sayfasına yönlendir
        break;
      case 3:
        screen = const settings.SettingsPage(); // Settings sayfasına yönlendir
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _logOut() {
    // Çıkış işlemlerini gerçekleştir ve login ekranına yönlendir
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Menu'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logOut,
          ),
        ],
      ),
      body: const Analysis(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // ListTile(
            //   leading: const Icon(Icons.home),
            //   title: const Text('Main Menu'),
            //   onTap: () => _onItemTapped(0),
            // ),
            ListTile(
              leading: const Icon(Icons.business),
              title: const Text('Business'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('School'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}
