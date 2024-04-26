import 'package:anime_slayer/anime_controller.dart';
import 'package:anime_slayer/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import 'anime_card.dart';

class AnimeGrid extends ConsumerWidget {
  const AnimeGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(animesControllerProvider).animes;
    return animes.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: $e'),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(animesControllerProvider.notifier).fetchAnimes();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
        data: (animes) => ResponsiveGridList(
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
            ));
  }
}
