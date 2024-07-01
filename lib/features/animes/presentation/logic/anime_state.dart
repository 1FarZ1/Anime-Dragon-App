// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimeState {
  final AsyncValue<List<AnimeModel>> animes;

  AnimeState({
    this.animes = const AsyncValue.loading(),
  });


  List<AnimeModel> get favoriteAnimes {
    return animes.asData!.value.where((element) => element.isFavorite).toList();
  }

  List<AnimeModel> get myAnimes {
    return animes.asData!.value.where((element) => element.isInMyList).toList();
  }

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
