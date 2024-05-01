import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'characters_view.dart';
import 'episodes_view.dart';
import 'main_detaill_view.dart';
import 'widgets/favorite_button.dart';
import 'widgets/options_action.dart';
import 'top_bar_view.dart';

class AnimeDetaillsScreen extends HookConsumerWidget {
  const AnimeDetaillsScreen({super.key, required this.animeId});

  final int animeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 4);
    final anime = ref.watch(singleAnimeProvider(animeId));
    return Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text(
            anime!.title,
            style: TextStyle(
              fontSize: 22.sp,
            ),
          ),
          actions: [
            FavoriteButton(
              animeId: animeId,
            ),
            const OptionsAction(),
          ],
        ),
        body: Column(
          children: [
            TopBarView(
              tabController: tabController,
            ),
            10.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  MainDetaillView(anime: anime),
                  EpisodesView(
                    numberOfEpisodes: anime.lastEpisode,
                  ),
                  const Center(child: Text('Released Soon ')),
                  CharactersView(anime.characters),
                ],
              ),
            )
          ],
        ));
  }
}

enum CharacterType {
  main,
  support,
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.pop();
      },
    );
  }
}
