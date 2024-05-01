// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:anime_slayer/features/animes/presentation/anime_detaills_screen.dart';

class AnimeModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final bool isEnded;
  final int lastEpisode;
  final int minAge;
  final DateTime releaseDate;
  final String source;
  final StudioModel studio;
  final List<CharacterModel> characters;
  final int reviewsCount;
  // final List<AnimeModel> relatedAnimes;

  AnimeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.isEnded,
    required this.lastEpisode,
    required this.minAge,
    required this.releaseDate,
    required this.source,
    required this.studio,
    required this.characters,
    required this.reviewsCount,
  });

  AnimeModel copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    double? rating,
    bool? isEnded,
    int? lastEpisode,
    int? minAge,

    DateTime? releaseDate,
    String? source,
    StudioModel? studio,
    List<CharacterModel>? characters,
    int? reviewsCount,
  }) {
    return AnimeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      isEnded: isEnded ?? this.isEnded,
      lastEpisode: lastEpisode ?? this.lastEpisode,
      minAge: minAge ?? this.minAge,
      releaseDate: releaseDate ?? this.releaseDate,
      source: source ?? this.source,
      studio: studio ?? this.studio,
      characters: characters ?? this.characters,
      reviewsCount: reviewsCount ?? this.reviewsCount,
    );
  }

  

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['image'] as String,
      rating: map['rating'] as double,
      isEnded: map['Ended'] as bool,
      lastEpisode: map['lastEpisode'] as int,
      minAge: map['minAge'] as int,
      source: map['source'] as String,
      releaseDate: DateTime.parse(map['releaseDate'] as String),
      studio: StudioModel.fromMap(map['studio'] as Map<String, dynamic>),
      characters: List<CharacterModel>.from(map['characters']
              ?.map((x) => CharacterModel.fromMap(x as Map<String, dynamic>)))
          .toList(),
      reviewsCount: map['reviewsCount'] as int,
    );
  }

  @override
  String toString() {
    return 'AnimeModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, rating: $rating, isEnded: $isEnded, lastEpisode: $lastEpisode, minAge: $minAge, releaseDate: $releaseDate, source: $source, studio: $studio)';
  }

  @override
  bool operator ==(covariant AnimeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.rating == rating &&
        other.isEnded == isEnded &&
        other.lastEpisode == lastEpisode &&
        other.minAge == minAge &&
        other.releaseDate == releaseDate &&
        other.source == source &&
        other.studio == studio;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        rating.hashCode ^
        isEnded.hashCode ^
        lastEpisode.hashCode ^
        minAge.hashCode ^
        releaseDate.hashCode ^
        source.hashCode ^
        studio.hashCode;
  }
}

class StudioModel {
  final int id;
  final String name;

  StudioModel({
    required this.id,
    required this.name,
  });

  StudioModel copyWith({
    int? id,
    String? name,
  }) {
    return StudioModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory StudioModel.fromMap(Map<String, dynamic> map) {
    return StudioModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudioModel.fromJson(String source) =>
      StudioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StudioModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant StudioModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class CharacterModel {
  // id , name, role , image
  final int id;
  final String name;
  final CharacterType role;
  final String imageUrl;

  CharacterModel({
    required this.id,
    required this.name,
    required this.role,
    required this.imageUrl,
  });

  CharacterModel copyWith({
    int? id,
    String? name,
    CharacterType? role,
    String? imageUrl,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'imageUrl': imageUrl,
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'] as int,
      name: map['name'] as String,
      role: map['role'] == 'main' ? CharacterType.main : CharacterType.support,
      imageUrl: map['image'] as String,
    );
  }
}
