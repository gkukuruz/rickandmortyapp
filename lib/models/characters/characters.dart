import 'package:rickandmortyapp/models/characters/character.dart';

class Characters {
  final CharactersInfo info;
  final List<Character> list;

  Characters({
    required this.info,
    required this.list
  });

  factory Characters.fromJson(Map<String, dynamic> json) {
    return Characters(
      info: CharactersInfo.fromJson(json['info']),
      list: json['results'].map<Character>((character) => Character.fromJson(character)).toList()
    );
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
}
