import 'package:flutter/material.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:rickandmortyapp/repositories/favorites_repository.dart';

class FavoritesProvider with ChangeNotifier {
  final FavoritesRepository repository;

  bool isFavorite(int id) => repository.isFavorite(id);
  List<Character> get favorites => repository.getAllFavorites();

  FavoritesProvider({
    required this.repository
  });

  Future<void> toggleFavorite(Character character) async {
    if (repository.isFavorite(character.id)) {
      await repository.removeFromFavorites(character.id);
    } else {
      await repository.addToFavorites(character);
    }
    notifyListeners();
  }
}