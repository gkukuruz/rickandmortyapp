class EpisodeResponse {
  final int id;
  final String name;
  final String air_date;
  final String episode;
  final List<String> characters;
  final String url;
  final String created;

  EpisodeResponse({
    required this.id,
    required this.name,
    required this.air_date,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeResponse(
      id: json['id'],
      name: json['name'],
      air_date: json['air_date'],
      episode: json['episode'],
      characters: json['characters'].map<String>((character) => character.toString()).toList(),
      url: json['url'],
      created: json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'air_date': air_date,
      'episode': episode,
      'characters': characters,
      'url': url,
      'created': created,
    };
  }
}