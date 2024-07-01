import 'package:anime_slayer/features/anime_drawer.dart';
import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';
import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:anime_slayer/features/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animes/presentation/widgets/anime_grid.dart';
import 'anime_list_controller.dart';
import 'open_drawer_button.dart';

class AnimeListScreen extends ConsumerWidget {
  const AnimeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(animesControllerProvider);
    final viewStyle = ref.watch(viewProvider);
    return Scaffold(
      drawer: const AnimeDrawer(),
      appBar: AppBar(
        leading: const OpenDrawerButton(),
        title: const Text('قائمتي'),
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
        animeSync: animes.myAnimes,
        onRefresh: () async {
          ref.invalidate(listAnimesController);
        },
        onError: () {
          ref.invalidate(
            listAnimesController,
          );
        },
        viewStyle: viewStyle,
      ),
    );
  }
}
