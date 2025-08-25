import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rickandmortyapp/models/characters/characters.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';
  late Dio _dio;
  late BaseCacheManager _cache;

  ApiService() {
    initialize();
  }

  Future<void> initialize() async {
    await _initDio();
    await _initCacheManager();
  }

  Future<void> _initDio() async {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  Future<void> _initCacheManager() async {
    _cache = DefaultCacheManager();
  }

  Future<Characters?> getCharacters({int page = 1, bool refreshCache = false}) async {
    if (_dio == null) {
      await initialize();
    }

    final url = '$_baseUrl/character?page=$page';
    final cacheKey = 'characters_page_$page';

    try {
      if (!refreshCache) {
        final cachedData = await _getCachedCharacters(cacheKey, url);
        if (cachedData != null) {
          return cachedData;
        }
      }

      final response = await _dio.get('/character?page=$page');

      if (response.statusCode == 200) {
        await _saveCharactersToCache(cacheKey, url, response.data);
        return Characters.fromJson(response.data);
      } else {
        throw Exception('Failed to load characters');
      }
    } on DioException catch(e) {
      print(e.message);
    }
  }

  Future<Characters?> _getCachedCharacters(String cacheKey, String url) async {
    try {
      final fileInfo = await _cache.getFileFromCache(cacheKey);

      if (fileInfo != null && fileInfo.file != null) {
        final age = DateTime.now().difference(fileInfo.validTill);
        if (age.inHours < 1) {
          final fileContent = await fileInfo.file.readAsString();
          final jsonData = json.decode(fileContent);
          print('Loaded from cache: $cacheKey');
          return Characters.fromJson(jsonData);
        } else {
          await _cache.removeFile(cacheKey);
        }
      }
    } catch (e) {
      print('Error reading from cache: $e');
    }
    return null;
  }

  Future<void> _saveCharactersToCache(String cacheKey, String url, dynamic data) async {
    try {
      final jsonString = json.encode(data);

      await _cache.putFile(
        cacheKey,
        utf8.encode(jsonString),
        key: cacheKey,
        maxAge: const Duration(days: 7),
        fileExtension: '.json',
      );

      print('Saved to cache: $cacheKey');
    } catch (e) {
      print('Error saving to cache: $e');
    }
  }
}