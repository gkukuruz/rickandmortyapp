import 'package:flutter/material.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:rickandmortyapp/repositories/repositories.dart';

class EpisodeProvider with ChangeNotifier {
  final EpisodesRepository _repository = EpisodesRepository();
  EpisodeResponse? episode;
  bool _isLoading = false;
  bool _dispose = false;

  bool get isLoading => _isLoading;

  Future<void> getEpisode({required String url}) async {
    if (_isLoading) return;

    _isLoading = true;
    if (!_dispose) {
      notifyListeners();
    }

    try {
      episode = await _repository.getEpisode(url: url);
    } catch(e) {
      print('episode load error: $e');
    } finally {
      _isLoading = false;
      if (!_dispose) {
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _dispose = true;
    super.dispose();
  }
}