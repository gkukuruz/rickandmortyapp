import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  //final List<String> episode;
  final String url;
  final String created;

  Future<File> get getImage => _getImage();

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    //required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: Origin.fromJson(json['origin']),
      location: Location.fromJson(json['location']),
      image: json['image'],
      url: json['url'],
      created: json['created']
    );
  }

  Future<File> _getImage() async {
    return await DefaultCacheManager().getSingleFile(
      image,
      headers: {"Cache-Control": "max-age=${60*60*24*7}"}, // 7 дней
    );
  }
}

class Origin {
  final String name;
  final String url;

  Origin({
    required this.name,
    required this.url
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      name: json['name'],
      url: json['url']
    );
  }
}

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        name: json['name'],
        url: json['url']
    );
  }
}