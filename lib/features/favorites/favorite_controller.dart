import 'package:anime_slayer/features/animes/data/animes_repository.dart';
import 'package:anime_slayer/utils/custom_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animes/domaine/anime_model.dart';

final favoriteAnimesController = StateNotifierProvider<FavoriteAnimesController,
    AsyncValue<List<AnimeModel>>>((ref) {
  return FavoriteAnimesController(ref.watch(animesRepositoryProvider));
});

class FavoriteAnimesController
    extends StateNotifier<AsyncValue<List<AnimeModel>>> {
  FavoriteAnimesController(this.animesRepository)
      : super(const AsyncValue.loading()) {
    fetchFavoriteAnimes();
  }

  final AnimesRepository animesRepository;

  void fetchFavoriteAnimes() async {
    state = const AsyncValue.loading();
    try {
      final animes = await animesRepository.getFavoriteAnime();
      state = AsyncValue.data(animes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void addFavoriteAnime(int animeId) async {
    try {
      state = const AsyncValue.loading();
      final anime = await animesRepository.addFavoriteAnime(animeId);
      state = AsyncValue.data([...state.asData!.value, anime]);

      // fetchFavoriteAnimes();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void removeFavoriteAnime(int animeId) async {
    try {
      state = const AsyncValue.loading();
      await animesRepository.removeFavoriteAnime(animeId);
      // logger.i(state.value);
      state = AsyncValue.data(state.asData!.value
          .where((element) => element.id != animeId)
          .toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
