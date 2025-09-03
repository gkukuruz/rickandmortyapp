import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:rickandmortyapp/services/services.dart';
import 'package:rickandmortyapp/widgets/widgets.dart';
import 'package:rickandmortyapp/providers/index.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({
    super.key,
    required this.character
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context, listen: true);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          character.image,
          cacheManager: CustomImageCacheManager()
        ),
      ),
      title: Text(character.name),
      subtitle: Text('${character.species}, ${character.gender}'),
      trailing: IconButton(
        onPressed: () {
          provider.toggleFavorite(character);
        },
        icon: Icon(provider.isFavorite(character.id) ? Icons.star : Icons.star_outline)
      ),
      onTap: () {
        _showCharacterInfo(context, character);
      },
    );
  }

  void _showCharacterInfo(BuildContext context, Character character) {
    final episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    if (character.episode.isNotEmpty) {
      episodeProvider.getEpisode(url: character.episode.first);
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CharacterInfo(character: character);
      }
    );
  }
}