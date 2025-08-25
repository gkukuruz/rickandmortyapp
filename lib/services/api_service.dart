import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rickandmortyapp/models/models.dart';

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';
  late Dio _dio;

  ApiService({Dio? dio}):
    _dio = dio ?? Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

  Future<CharactersResponse?> getCharacters({int page = 1, bool refreshCache = false}) async {
    try {
      final response = await _dio.get('/character', queryParameters: {
        'page': page
      });

      if (response.statusCode == 200) {
        return CharactersResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } on DioException catch(e) {
      print(e.message);
    }
  }
}