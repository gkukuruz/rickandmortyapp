import 'package:flutter/material.dart';
import 'package:rickandmortyapp/services/services.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:rickandmortyapp/repositories/repositories.dart';

class CharactersProvider with ChangeNotifier {
  final CharactersRepository _repository = CharactersRepository();
  List<Character> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _dispose = false;

  List<Character> get characters => _characters;
  int get currentPage => _currentPage;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadCharacters({int page = 1}) async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    if (!_dispose) {
      notifyListeners();
    }

    try {
      final response = await _repository.getCharacters(page: page);
      if (response != null) {
        if (response.results != null && response.results.isNotEmpty) {
          _characters.addAll(response.results);
          _currentPage = page;
        }
        if (response.info != null) {
          _hasMore = response.info.next != null;
        }
      }
    } catch(e) {
      print('load characters error: ${e}');
    } finally {
      _isLoading = false;
      if (!_dispose) {
        notifyListeners();
      }
    }
  }

  Future<void> loadMoreCharacters() async {
    if (_isLoading) return;
    await loadCharacters(page: _currentPage + 1);
  }

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }
}
