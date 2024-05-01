import 'package:anime_slayer/features/animes/data/animes_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animes/domaine/anime_model.dart';

final listAnimesController = StateNotifierProvider<ListAnimesController,
    AsyncValue<List<AnimeModel>>>((ref) {
  return ListAnimesController(ref.watch(animesRepositoryProvider));
});

class ListAnimesController
    extends StateNotifier<AsyncValue<List<AnimeModel>>> {
  ListAnimesController(this.animesRepository) : super(const AsyncValue.loading()) {
    fetchMyCollection();
  }

  final AnimesRepository animesRepository;

  void fetchMyCollection() async {
    state = const AsyncValue.loading();
    try {
      final animes = await animesRepository.getMyCollection();
      state = AsyncValue.data(animes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void addListAnime(int animeId) async {
    try {
      state = const AsyncValue.loading();
      await animesRepository.addToCollection(animeId);
      // TODO: maybe change this later on
      fetchMyCollection();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void removeListAnime(int animeId) async {
    try {
      state = const AsyncValue.loading();
      await animesRepository.removeFromCollection(animeId);

      state = AsyncValue.data(state.asData!.value
          .where((element) => element.id != animeId)
          .toList());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  
}
