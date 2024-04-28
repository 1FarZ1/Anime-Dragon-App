// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
