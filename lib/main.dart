import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/home.dart';
import 'package:rickandmortyapp/providers/index.dart';
import 'package:rickandmortyapp/repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsRepository = SettingsRepository();
  await settingsRepository.init();
  final favoritesRepository = FavoritesRepository();
  await favoritesRepository.init();

  runApp(MainApp(
    favoritesRepository: favoritesRepository,
    settingsRepository: settingsRepository
  ));
}

class MainApp extends StatelessWidget {
  final FavoritesRepository favoritesRepository;
  final SettingsRepository settingsRepository;

  const MainApp({
    super.key,
    required this.favoritesRepository,
    required this.settingsRepository
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CharactersRepository>(
          create: (_) => CharactersRepository(),
        ),
        ChangeNotifierProvider<CharactersProvider>(create: (context) => CharactersProvider(
            repository: context.read<CharactersRepository>()
        )),
        ChangeNotifierProvider<EpisodeProvider>(create: (_) => EpisodeProvider()),
        ChangeNotifierProvider<FavoritesProvider>(create: (_) => FavoritesProvider(repository: favoritesRepository)),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider(repository: settingsRepository)),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Rick And Morty App',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            home: const HomeView()
          );
        }
      )
    );
  }
}
