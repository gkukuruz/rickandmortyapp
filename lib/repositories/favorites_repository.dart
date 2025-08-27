import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:rickandmortyapp/models/models.dart';

class FavoritesRepository {
  static const String _boxName = 'favoritesBox';
  late Box<String> _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
  }

  Future<void> addToFavorites(Character character) async {
    await _box.put(character.id, jsonEncode(character.toJson()));
  }

  Future<void> removeFromFavorites(int characterId) async {
    await _box.delete(characterId);
  }

  bool isFavorite(int characterId) {
    return _box.containsKey(characterId);
  }

  List<Character> getAllFavorites() {
    final list = _box.values.map((json) {
      final jsonMap = jsonDecode(json) as Map<String, dynamic>;
      return Character.fromJson(jsonMap);
    }).toList();

    list.sort((a, b) => a.name.compareTo(b.name));

    return list;
  }

  Stream<List<Character>> watchFavorites() {
    return _box.watch().map((event) => getAllFavorites());
  }
}