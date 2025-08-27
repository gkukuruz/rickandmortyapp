import 'package:flutter/material.dart';
import 'package:rickandmortyapp/repositories/repositories.dart';

class ThemeProvider with ChangeNotifier {
  final SettingsRepository repository;
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider({
    required this.repository
  });

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    try {
      await repository.saveThemeMode(mode);
      notifyListeners();
    } catch(e) {
      print('theme mode switch error: $e');
    }
  }

  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    try {
      await setThemeMode(newMode);
    } catch(e) {
      print('theme mode save error: $e');
    }
  }
}