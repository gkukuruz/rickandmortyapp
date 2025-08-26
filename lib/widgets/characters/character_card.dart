import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:rickandmortyapp/services/services.dart';
import 'package:rickandmortyapp/widgets/widgets.dart';
import 'package:rickandmortyapp/providers/episode_provider.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({
    required this.character
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
          character.image,
          cacheManager: CustomImageCacheManager()
        ),
      ),
      title: Text(character.name),
      subtitle: Text('${character.species}, ${character.gender}'),
      trailing: Icon(Icons.star_outline),
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