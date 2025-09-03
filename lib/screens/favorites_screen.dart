import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmortyapp/providers/index.dart';
import 'package:rickandmortyapp/widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);
    final favorites = provider.favorites;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: favorites[index],
                );
              }
            )
          ),
        ],
      )
    );
  }
}