import 'package:dio/dio.dart';
import 'package:rickandmortyapp/models/models.dart';

class ApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com';
  late final Dio _dio;

  ApiService({Dio? dio}):
    _dio = dio ?? Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

  Future<CharactersResponse?> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get('/api/character', queryParameters: {
        'page': page
      });

      if (response.statusCode == 200) {
        return CharactersResponse.fromJson(response.data);
      } else {
        throw Exception('failed to load characters: ${response.statusCode}');
      }
    } on DioException catch(e) {
      print(e.message);
    }

    return null;
  }

  Future<EpisodeResponse?> getEpisode({required String path}) async {
    try {
      final response = await _dio.get(path);

      if (response.statusCode == 200) {
        return EpisodeResponse.fromJson(response.data);
      } else {
        throw Exception('failed to load characters: ${response.statusCode}');
      }
    } on DioException catch(e) {
      print(e.message);
      return null;
    }
  }
}
