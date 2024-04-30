import 'package:anime_slayer/features/anime_drawer.dart';
import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animes/presentation/widgets/anime_grid.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(favoriteAnimesController);

    return Scaffold(
      // this is redunancy and should be avoided
      drawer: const AnimeDrawer(),
      appBar: AppBar(
        leading: const OpenDrawerButton(),
        title: const Text('المفضلة'),
        actions: [
          // saech
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // context.pushNamed(
              //   AppRoutes.search.name,
              // );
            },
          ),
          // list view
          IconButton(
            icon: const Icon(Icons.grid_view),
            onPressed: () {
              // ref.read(animeViewControllerProvider.notifier).switchView();
            },
          ),

          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // showReportIssue(context);
            },
          ),
        ],
      ),
      body: AnimesView(
        animes: animes,
        onRefresh: () async {
          ref.invalidate(favoriteAnimesController);
        },
        onError: () {
          ref.invalidate(
            favoriteAnimesController,
          );
        },
      ),
    );
  }
}

class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    });
  }
}
