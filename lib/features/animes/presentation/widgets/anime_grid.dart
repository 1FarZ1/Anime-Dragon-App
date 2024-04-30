// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';

import 'anime_card.dart';

//TODO: Add AsyncValue Widget

//TODO: I really need to fix the  auth logic in this app
class AnimesView extends ConsumerWidget {
  const AnimesView({
    super.key,
    required this.animes,
    required this.onRefresh,
    required this.onError,
  });

  final AsyncValue<List<AnimeModel>> animes;

  final Future<void> Function() onRefresh;

  final Function() onError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return animes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $e'),
                  ElevatedButton(
                    onPressed: onError,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
        data: (animes) => AnimesGridView(
              animes: animes,
              onRefresh: onRefresh,
            ));
  }
}

class AnimesGridView extends StatelessWidget {
  const AnimesGridView({
    super.key,
    required this.animes,
    required this.onRefresh,
  });

  final List<AnimeModel> animes;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ResponsiveGridList(
        horizontalGridSpacing: 0,
        verticalGridSpacing: 10,
        horizontalGridMargin: 15,
        verticalGridMargin: 10,
        minItemWidth: 130,
        minItemsPerRow: 3,
        maxItemsPerRow: 5,
        listViewBuilderOptions: ListViewBuilderOptions(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
        ),
        children: [
          ...animes.map(
            (anime) => AnimeCard(
              anime: anime,
            ),
          )
        ],
      ),
    );
  }
}
