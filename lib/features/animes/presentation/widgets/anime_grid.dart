// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_slayer/features/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'package:anime_slayer/features/animes/domaine/anime_model.dart';

import 'anime_grid_card.dart';
import 'anime_list_card.dart';

//TODO: I really need to fix the  auth logic in this app
class AnimesView extends ConsumerWidget {
  const AnimesView({
    super.key,
    this.animesAsync,
    this.animeSync,
    required this.onRefresh,
    required this.onError,
    this.viewStyle = ViewStyle.grid,
  }) : assert(animesAsync != null || animeSync != null);

  final AsyncValue<List<AnimeModel>>? animesAsync;
  final List<AnimeModel>? animeSync;

  final Future<void> Function() onRefresh;

  final Function() onError;

  final ViewStyle viewStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return animeSync != null
        ? viewStyle == ViewStyle.grid
            ? AnimesGridView(
                animes: animeSync!,
                onRefresh: onRefresh,
              )
            : AnimesListView(
                animes: animeSync!,
                onRefresh: onRefresh,
              )
        : animesAsync!.when(
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
            data: (animes) {
              if (animes.isEmpty) {
                return const Center(
                  child: Text('No animes found'),
                );
              }
              return viewStyle == ViewStyle.grid
                  ? AnimesGridView(
                      animes: animes,
                      onRefresh: onRefresh,
                    )
                  : AnimesListView(
                      animes: animes,
                      onRefresh: onRefresh,
                    );
            });
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
            (anime) => AnimeGridCard(
              anime: anime,
            ),
          )
        ],
      ),
    );
  }
}

class AnimesListView extends StatelessWidget {
  const AnimesListView({
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
      child: ListView.builder(
        itemCount: animes.length,
        itemBuilder: (context, index) {
          final anime = animes[index];
          return AnimeListCard(
            anime: anime,
          );
        },
      ),
    );
  }
}
