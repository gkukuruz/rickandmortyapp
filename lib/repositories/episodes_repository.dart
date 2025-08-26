import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rickandmortyapp/models/models.dart';
import 'package:rickandmortyapp/services/services.dart';

class EpisodesRepository {
  final ApiService _api;
  final BaseCacheManager _cache;

  EpisodesRepository({ApiService? api, BaseCacheManager? cache}):
    _api = api ?? ApiService(),
    _cache = cache ?? DefaultCacheManager();

  Future<EpisodeResponse?> getEpisode({required String url, bool refreshCache = false}) async {
    String path = Uri.parse(url).path;
    final cacheKey = 'episode$path';

    if (!refreshCache) {
      try {
        final cachedData = await _getCachedData(cacheKey);
        if (cachedData != null) {
          return cachedData;
        }
      } catch(e) {
        print('get episode from cache error: $e');
      }
    }

    try {
      final characters = await _api.getEpisode(path: path);
      if (characters != null) {
        await _saveToCache(cacheKey, characters);
        return characters;
      }
    } catch(e) {
      if (!refreshCache) {
        final cachedData = await _getCachedData(cacheKey);
        if (cachedData != null) {
          return cachedData;
        }
      }
      print('get episode network error: ${e}');
    }
  }

  Future<EpisodeResponse?> _getCachedData(String cacheKey) async {
    try {
      final fileInfo = await _cache.getFileFromCache(cacheKey);

      if (fileInfo != null && fileInfo.file != null) {
        final content = await fileInfo.file.readAsString();
        final jsonData = json.decode(content);
        print('load from cache: $cacheKey');
        return EpisodeResponse.fromJson(jsonData);
      }
    } catch(e) {
      print('error reading from cache: $e');
    }
    return null;
  }

  Future<void> _saveToCache(String cacheKey, EpisodeResponse data) async {
    try {
      final jsonString = json.encode(data);
      await _cache.putFile(
        cacheKey,
        utf8.encode(jsonString),
        key: cacheKey,
        maxAge: const Duration(days: 7),
      );
      print('saved to cache: $cacheKey');
    } catch(e) {
      print('error saving episode to cache: $e');
    }
  }
}