import 'package:anime_slayer/providers/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../consts/endpoints.dart';
import '../domaine/anime_model.dart';
import '../presentation/logic/filter_type.dart';

final animesRepositoryProvider = Provider<AnimesRepository>((ref) {
  return AnimesRepositoryImpl(ref.watch(dioClientProvider));
});

class AddReviewRequest {
  final int animeId;
  final double rating;

  AddReviewRequest({
    required this.animeId,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'animeId': animeId,
      'rating': rating,
    };
  }

  AddReviewRequest copyWith({
    int? animeId,
    double? rating,
  }) {
    return AddReviewRequest(
      animeId: animeId ?? this.animeId,
      rating: rating ?? this.rating,
    );
  }
}

class AddReviewResponse {
  final double newRating;
  final int numReviewers;
  final List<Votes> votes;

  AddReviewResponse({
    required this.newRating,
    required this.votes,
    required this.numReviewers,
  });

  // from json
  factory AddReviewResponse.fromMap(Map<String, dynamic> map) {
    return AddReviewResponse(
      newRating:
          map['rating']['averageRating'] is double
              ? map['rating']['averageRating'] as double
              : (map['rating']['averageRating'] as int).toDouble(),
      numReviewers: map['rating']['numberOfReviews'] as int,
      votes: List<Votes>.from(map['votes'].map((x) => Votes.fromMap(x))),
    );
  }
}

abstract class AnimesRepository {
  Future<List<AnimeModel>> fetchAnimes();
  Future<List<AnimeModel>> searchAnimes(
      {String query = "", FilterType filter = FilterType.title});

  Future<List<AnimeModel>> getFavoriteAnime();
  // add favorite
  Future<AnimeModel> addFavoriteAnime(int animeId);
  Future<void> removeFavoriteAnime(int animeId);

  Future<AddReviewResponse> addReviewToAnime(AddReviewRequest addReviewRequest);

  //collections
  Future<List<AnimeModel>> getMyCollection();
  // add to collection
  Future<void> addToCollection(int animeId);
  Future<void> removeFromCollection(int animeId);
}

class AnimesRepositoryImpl implements AnimesRepository {
  AnimesRepositoryImpl(this.dioClient);

  final DioClient dioClient;

  @override
  Future<List<AnimeModel>> fetchAnimes() async {
    final response = await dioClient.get(EndPoints.animes);
    return (response.data as List).map((e) => AnimeModel.fromMap(e)).toList();
  }

  @override
  Future<List<AnimeModel>> searchAnimes(
      {String query = "", FilterType filter = FilterType.title}) async {
    final response = await dioClient.get(
        "${EndPoints.animesSearch}?query=$query&orderBy=${filter.name}&&order=desc");

    return (response.data as List).map((e) => AnimeModel.fromMap(e)).toList();
  }

  @override
  Future<List<AnimeModel>> getFavoriteAnime() async {
    final response = await dioClient.get(EndPoints.favoritesAnime);
    return (response.data as List).map((e) => AnimeModel.fromMap(e)).toList();
  }

  @override
  Future<AnimeModel> addFavoriteAnime(int animeId) async {
    final response = await dioClient
        .post("${EndPoints.favoriteOperation}/$animeId", data: {});
    return AnimeModel.fromMap(response.data['anime']);
  }

  @override
  Future<void> removeFavoriteAnime(int animeId) async {
    await dioClient.delete("${EndPoints.favoriteOperation}/$animeId");
  }

  @override
  Future<AddReviewResponse> addReviewToAnime(
      AddReviewRequest addReviewRequest) async {
    final resposne = await dioClient.post(EndPoints.addReview,
        data: addReviewRequest.toMap());
    return AddReviewResponse.fromMap(resposne.data);
  }

  @override
  Future<List<AnimeModel>> getMyCollection() async {
    final response = await dioClient.get(EndPoints.myCollection);
    return (response.data as List).map((e) => AnimeModel.fromMap(e)).toList();
  }

  @override
  Future<void> addToCollection(int animeId) async {
    await dioClient.post("${EndPoints.collection}/$animeId", data: {});
  }

  @override
  Future<void> removeFromCollection(int animeId) async {
    await dioClient.delete("${EndPoints.collection}/$animeId");
  }
}
