import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsRepository {
  static const String _boxName = 'settingsBox';
  static const String _themeModeKey = 'theme_mode';
  late Box<String> _box;

  bool get isDarkMode {
    final theme = getThemeMode();
    return theme == ThemeMode.dark;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _box.put(_themeModeKey, mode.toString());
  }

  ThemeMode getThemeMode() {
    final themeString = _box.get(_themeModeKey);
    if (themeString == null) return ThemeMode.system;

    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == themeString,
      orElse: () => ThemeMode.system
    );
  }
}
