class AnimeModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final int rating;
  final bool isEnded;
  final int lastEpisode;

  AnimeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.isEnded,
    required this.lastEpisode,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image'],
      rating: json['rating'],
      isEnded: json['Ended'],
      lastEpisode: json['lastEpisode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'Ended': isEnded,
      'lastEpisode': lastEpisode,
    };
  }

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
      isEnded: map['Ended'],
      lastEpisode: map['lastEpisode'],  
    );
  }

  @override
  String toString() {
    return 'AnimeModel{id: $id, title: $title, description: $description, imageUrl: $imageUrl}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimeModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.rating == rating &&
        other.isEnded == isEnded &&
        other.lastEpisode == lastEpisode &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        isEnded.hashCode ^
        lastEpisode.hashCode ^
        rating.hashCode;
  }
}
