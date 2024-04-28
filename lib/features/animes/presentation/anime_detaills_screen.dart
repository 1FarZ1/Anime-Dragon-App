import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            anime!.title,
            style: TextStyle(
              fontSize: 22.sp,
            ),
          ),
          actions: const [
            FavoriteButton(),
            OptionsAction(),
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
                  const Center(child: Text('الاحصائيات')),
                  const Center(child: Text('الشخصيات')),
                ],
              ),
            )
          ],
        ));
  }
}
