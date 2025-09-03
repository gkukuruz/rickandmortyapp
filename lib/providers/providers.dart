import 'package:provider/provider.dart';
import 'package:rickandmortyapp/providers/index.dart';
import 'package:rickandmortyapp/repositories/repositories.dart';

List<ChangeNotifierProvider> getProviders(FavoritesRepository favoritesRepository, SettingsRepository settingsRepository) => [
  ChangeNotifierProvider<CharactersProvider>(create: (_) => CharactersProvider()),
  ChangeNotifierProvider<EpisodeProvider>(create: (_) => EpisodeProvider()),
  ChangeNotifierProvider<FavoritesProvider>(create: (_) => FavoritesProvider(repository: favoritesRepository)),
  ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider(repository: settingsRepository)),
];