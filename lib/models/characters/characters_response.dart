import 'package:rickandmortyapp/models/characters/character.dart';

class CharactersResponse {
  final CharactersInfo info;
  final List<Character> results;

  CharactersResponse({
    required this.info,
    required this.results
  });

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      info: CharactersInfo.fromJson(json['info']),
      results: json['results'].map<Character>((character) => Character.fromJson(character)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'info': info.toJson(),
      'results': results.map((character) => character.toJson()).toList()
    };
  }
}

class CharactersInfo {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  CharactersInfo({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev
  });
  
  factory CharactersInfo.fromJson(Map<String, dynamic> json) {
    return CharactersInfo(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'pages': pages,
      'next': next,
      'prev': prev
    };
  }
}
