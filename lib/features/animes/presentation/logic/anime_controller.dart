// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'package:anime_slayer/features/animes/presentation/search_option.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_slayer/features/animes/data/animes_repository.dart';
import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'anime_state.dart';

final animesControllerProvider =
    StateNotifierProvider<AnimeController, AnimeState>((ref) {
  return AnimeController(
    ref.watch(animesRepositoryProvider),
  );
});

final animeSearchProvider = FutureProvider.family
    .autoDispose<List<AnimeModel>, SearchOption>((ref, searchOption) async {
  final link = ref.keepAlive();

  Timer(const Duration(seconds: 3), () {
    link.close();
  });
  final animes = await ref
      .watch(animesRepositoryProvider)
      .searchAnimes(query: searchOption.query, filter: searchOption.filter);
  return animes;
});

final singleAnimeProvider = Provider.family<AnimeModel?, int>((ref, id) {
  final animes = ref.watch(animesControllerProvider).animes.asData?.value;
  return animes?.firstWhere((element) => element.id == id);
});

class AnimeController extends StateNotifier<AnimeState> {
  AnimeController(this.animesRepository) : super(AnimeState()) {
    fetchAnimes();
  }

  final AnimesRepository animesRepository;

  void fetchAnimes() async {
    state = state.copyWith(animes: const AsyncValue.loading());
    try {
      final animes = await animesRepository.fetchAnimes();
      state = state.copyWith(animes: AsyncValue.data(animes));
    } catch (e, st) {
      state = state.copyWith(animes: AsyncValue.error(e, st));
    }
  }
}
