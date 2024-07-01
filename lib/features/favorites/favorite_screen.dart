import 'package:anime_slayer/features/anime_drawer.dart';
import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';
import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:anime_slayer/features/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animes/presentation/widgets/anime_grid.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(animesControllerProvider);
    final viewStyle = ref.watch(viewProvider);
    return Scaffold(
      // this is redunancy and should be avoided
      drawer: const AnimeDrawer(),
      appBar: AppBar(
        leading: const OpenDrawerButton(),
        title: const Text('المفضلة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
         
            },
          ),
          // list view
          SwitchViewWidget(viewStyle: viewStyle),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // showReportIssue(context);
            },
          ),
        ],
      ),
      body: AnimesView(
        animeSync: animes.favoriteAnimes,
        onRefresh: () async {
          // ref.invalidate(favoriteAnimesController);
        },
        onError: () {
          ref.invalidate(
            animesControllerProvider,
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
