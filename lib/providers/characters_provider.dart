import 'package:flutter/material.dart';
import 'package:rickandmortyapp/services/export.dart';
import 'package:rickandmortyapp/models/characters/export.dart';

class CharactersProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Character> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;

  Future<void> loadCharacters({int page = 1}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    final response = await _apiService.getCharacters(page: page);
    if (response != null && response.list.isNotEmpty) {
      _characters.addAll(response.list);
    }

    _isLoading = false;
    _currentPage = page;

    notifyListeners();
  }

  Future<void> loadMoreCharacters() async {
    if (_isLoading) return;
    await loadCharacters(page: _currentPage + 1);
  }
}
