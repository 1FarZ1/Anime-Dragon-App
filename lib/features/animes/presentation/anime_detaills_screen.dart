import 'package:anime_slayer/features/animes/presentation/anime_controller.dart';
import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/features/episode/watch_episode_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/anime_detaill_header.dart';
import 'widgets/description_section.dart';
import 'widgets/favorite_button.dart';
import 'widgets/options_action.dart';
import 'widgets/stats_section.dart';
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
                  FirstView(anime: anime),
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

class EpisodesView extends StatelessWidget {
  const EpisodesView({
    super.key,
    required this.numberOfEpisodes,
  });

  final int numberOfEpisodes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: numberOfEpisodes,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text('الحلقة ${index + 1}'),
            trailing: const Icon(Icons.remove_red_eye),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WatchEpisodeScreen(
                      episodeNumber: index + 1,
                    ))));
      },
    );
  }
}

class FirstView extends StatelessWidget {
  const FirstView({super.key, required this.anime});

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimeDetaillHeader(anime: anime),
        10.verticalSpace,
        StatsSection(anime: anime),
        10.verticalSpace,
        DescriptionSection(anime: anime),
      ],
    );
  }
}
