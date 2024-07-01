// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';
import 'package:anime_slayer/features/animes/presentation/search_option.dart';
import 'package:anime_slayer/features/auth/presentation/user_notifier.dart';
import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_slayer/features/animes/data/animes_repository.dart';
import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'anime_state.dart';

final animesControllerProvider =
    StateNotifierProvider<AnimeController, AnimeState>((ref) {
  return AnimeController(ref.watch(animesRepositoryProvider), ref);
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

// final isFavoriteAnimeProvider = Provider.family<bool, int>((ref, id) {
//   if (ref.watch(favoriteAnimesController).asData == null) {
//     return false;
//   }
//   final favoriteAnimes = ref.watch(favoriteAnimesController).asData!.value;
//   final isFavorite = favoriteAnimes.any((element) => element.id == id);

//   return isFavorite;
// });

final singleAnimeProvider = Provider.family<AnimeModel?, int>((ref, id) {
  final animes = ref.watch(
      animesControllerProvider.select((value) => value.animes.asData?.value));
  final anime = animes?.firstWhere((element) => element.id == id);

  return anime;
});

class AnimeController extends StateNotifier<AnimeState> {
  AnimeController(this.animesRepository, this.ref) : super(AnimeState()) {
    fetchAnimes();

    ref.listen(userProvider, (_, next) {
      if (next.isLoggedIn) {
        fetchAnimes();
      } else {
        fetchAnimes();
      }
    });
  }

  final AnimesRepository animesRepository;
  final Ref ref;
  void fetchAnimes() async {
    state = state.copyWith(animes: const AsyncValue.loading());
    try {
      final animes = await animesRepository.fetchAnimes();
      state = state.copyWith(animes: AsyncValue.data(animes));
    } catch (e, st) {
      log('Error while fetching animes', error: e, stackTrace: st);
      state = state.copyWith(animes: AsyncValue.error(e, st));
    }
  }

  void toggleisInList(animeId) {
    final animes = state.animes.asData?.value;
    if (animes == null) return;
    final anime = animes.firstWhere((element) => element.id == animeId);
    final newAnime = anime.copyWith(isInMyList: !anime.isInMyList);
    final newAnimes =
        animes.map((e) => e.id == animeId ? newAnime : e).toList();
    state = state.copyWith(animes: AsyncValue.data(newAnimes));
  }

  void toggleFavorite(animeId) {
    final animes = state.animes.asData?.value;
    if (animes == null) return;
    final anime = animes.firstWhere((element) => element.id == animeId);
    final newAnime = anime.copyWith(isFavorite: !anime.isFavorite);
    final newAnimes =
        animes.map((e) => e.id == animeId ? newAnime : e).toList();
    state = state.copyWith(animes: AsyncValue.data(newAnimes));
  }

  void addReviewToAnime(AddReviewRequest addReviewRequest) async {
    try {
      final AddReviewResponse addReviewData =
          await animesRepository.addReviewToAnime(addReviewRequest);
      final animes = state.animes.asData?.value;
      if (animes == null) return;
      AnimeModel anime = animes
          .firstWhere((element) => element.id == addReviewRequest.animeId);

      if (!anime.isReviewed) {
        anime = anime.copyWith(isReviewed: true);
      }
      final newAnime = anime.copyWith(
          rating: addReviewData.newRating,
          reviewsCount: addReviewData.numReviewers,
          votes: addReviewData.votes);
      final newAnimes = animes
          .map((e) => e.id == addReviewRequest.animeId ? newAnime : e)
          .toList();
      state = state.copyWith(animes: AsyncValue.data(newAnimes));
    } catch (e, st) {
      log('Error while adding review to anime', error: e, stackTrace: st);
    }
  }
}
