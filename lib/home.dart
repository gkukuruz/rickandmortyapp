import 'package:flutter/material.dart';
import 'package:rickandmortyapp/screens/screens.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentScreenIndex = 0;
  final List<Widget> _screens = [
    CharactersScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        onTap: (index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.account_circle_rounded),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Characters'
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.star),
            icon: Icon(Icons.star_outline),
            label: 'Favorites'
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: 'Settings'
          ),
        ],
      ),
    );
  }
}
