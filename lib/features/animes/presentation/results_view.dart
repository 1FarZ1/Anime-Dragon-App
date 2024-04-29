import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/anime_grid.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({
    super.key,
    required this.animes,
  });

  final List<AnimeModel> animes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimesGridView(
        animes: animes,
        onRefresh: () async {},
      ),
    );
  }
}
