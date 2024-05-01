// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'isEnded': isEnded,
      'lastEpisode': lastEpisode,
      'minAge': minAge,
      'releaseDate': releaseDate.millisecondsSinceEpoch,
      'source': source,
      'studio': studio.toMap(),
    };
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
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeModel.fromJson(String source) => AnimeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AnimeModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, rating: $rating, isEnded: $isEnded, lastEpisode: $lastEpisode, minAge: $minAge, releaseDate: $releaseDate, source: $source, studio: $studio)';
  }

  @override
  bool operator ==(covariant AnimeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
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

  factory StudioModel.fromJson(String source) => StudioModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StudioModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant StudioModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
