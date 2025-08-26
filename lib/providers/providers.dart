import 'package:provider/provider.dart';
import 'characters_provider.dart';
import 'episode_provider.dart';

List<ChangeNotifierProvider> get providers => [
  ChangeNotifierProvider<CharactersProvider>(create: (_) => CharactersProvider()),
  ChangeNotifierProvider<EpisodeProvider>(create: (_) => EpisodeProvider()),
];