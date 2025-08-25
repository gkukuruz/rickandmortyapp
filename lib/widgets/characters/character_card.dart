import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rickandmortyapp/models/characters/character.dart';
import 'package:rickandmortyapp/services/custom_image_cache_manager.dart';

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
    );
  }
}