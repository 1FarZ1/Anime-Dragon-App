import 'dart:async';

import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/consts/endpoints.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/dio.dart';

final animesControllerProvider =
    StateNotifierProvider<AnimeController, AnimeState>((ref) {
  return AnimeController(
    ref.watch(dioClientProvider),
  );
});

final animeSearchProvider = FutureProvider.family
    .autoDispose<List<AnimeModel>, String>((ref, query) async {
  final link = ref.keepAlive();
  final animes = ref.watch(animesControllerProvider).animes.asData?.value;

  Timer(const Duration(seconds: 3), () {
    link.close();
  });

  //  do cancel token if we use real http client for search debounce
  if (query.isNotEmpty) {
    return await Future.value(animes!
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList());
  } else {
    // do sortihng by rating and  return it into new attay
    var sortedAnimes = animes!.toList();
    sortedAnimes.sort((a, b) => b.rating.compareTo(a.rating));
    return Future.value(sortedAnimes);
  }
});

final singleAnimeProvider = Provider.family<AnimeModel?, int>((ref, id) {
  final animes = ref.watch(animesControllerProvider).animes.asData?.value;
  return animes?.firstWhere((element) => element.id == id);
});

class AnimeController extends StateNotifier<AnimeState> {
  AnimeController(this.dioClient) : super(AnimeState()) {
    fetchAnimes();
  }

  final DioClient dioClient;

  void fetchAnimes() async {
    state = state.copyWith(animes: const AsyncValue.loading());
    try {
      final response = await dioClient.get(EndPoints.animes);
      final animes =
          (response.data as List).map((e) => AnimeModel.fromJson(e)).toList();

      state = state.copyWith(animes: AsyncValue.data(animes));
    } catch (e, st) {
      state = state.copyWith(animes: AsyncValue.error(e, st));
    }
  }
}

class AnimeState {
  final AsyncValue<List<AnimeModel>> animes;

  AnimeState({
    this.animes = const AsyncValue.loading(),
  });

  AnimeState copyWith({
    AsyncValue<List<AnimeModel>>? animes,
  }) {
    return AnimeState(
      animes: animes ?? this.animes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimeState && other.animes == animes;
  }
}
