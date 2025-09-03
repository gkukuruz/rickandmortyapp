import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rickandmortyapp/services/services.dart';
import 'package:rickandmortyapp/models/models.dart';

class CharactersRepository {
  final ApiService _api;
  final BaseCacheManager _cache;

  CharactersRepository({ApiService? api, BaseCacheManager? cache}):
    _api = api ?? ApiService(),
    _cache = cache ?? DefaultCacheManager();

  Future<CharactersResponse?> getCharacters({int page = 1, bool refreshCache = false}) async {
    final cacheKey = 'characters_page_$page';

    if (!refreshCache) {
      try {
        final cachedData = await _getCachedData(cacheKey);
        if (cachedData != null) {
          return cachedData;
        }
      } catch(e) {
        print('get characters from cache error: $e');
      }
    }

    try {
      final characters = await _api.getCharacters(page: page);
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
      print('get characters network error: $e');
    }

    return null;
  }

  Future<CharactersResponse?> _getCachedData(String cacheKey) async {
    try {
      final fileInfo = await _cache.getFileFromCache(cacheKey);

      if (fileInfo != null) {
        final content = await fileInfo.file.readAsString();
        final jsonData = json.decode(content);
        print('load from cache: $cacheKey');
        return CharactersResponse.fromJson(jsonData);
      }
    } catch(e) {
      print('error reading from cache: $e');
    }
    return null;
  }

  Future<void> _saveToCache(String cacheKey, CharactersResponse data) async {
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
      print('error saving characters to cache: $e');
    }
  }
}