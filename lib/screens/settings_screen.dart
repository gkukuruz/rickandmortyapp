import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rickandmortyapp/providers/index.dart';

class SettingsScreen extends StatelessWidget {

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark Theme:'),
                const Spacer(),
                Switch(
                  value: provider.isDarkMode ? true : false,
                  onChanged: (bool isDark) {
                    provider.setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
                  }),
              ],
            )
          ],
        ),
      )
    );
  }
}