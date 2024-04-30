import 'package:anime_slayer/providers/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../consts/endpoints.dart';
import '../domaine/anime_model.dart';
import '../presentation/logic/filter_type.dart';

final animesRepositoryProvider = Provider<AnimesRepository>((ref) {
  return AnimesRepositoryImpl(ref.watch(dioClientProvider));
});

abstract class AnimesRepository {
  Future<List<AnimeModel>> fetchAnimes();
  Future<List<AnimeModel>> searchAnimes(
      {String query = "", FilterType filter = FilterType.title});

  Future<List<AnimeModel>> getFavoriteAnime();
  // add favorite
  Future<void> addFavoriteAnime(int animeId);
  Future<void> removeFavoriteAnime(int animeId);
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
    return (response as List).map((e) => AnimeModel.fromMap(e)).toList();
  }

  @override
  Future<void> addFavoriteAnime(int animeId) async {
    await dioClient.post("${EndPoints.favoriteOperation}/$animeId", data: {});
  }

  @override
  Future<void> removeFavoriteAnime(int animeId) async {
    await dioClient.delete("${EndPoints.favoriteOperation}/$animeId");
  }
}
