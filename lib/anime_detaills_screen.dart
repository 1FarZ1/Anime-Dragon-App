import 'package:anime_slayer/anime_controller.dart';
import 'package:anime_slayer/anime_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'anime_detaill_header.dart';
import 'description_section.dart';
import 'reviewers_widget.dart';
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
            TabBarView(
              controller: tabController,
              children: [
                FirstView(anime: anime),
                const Center(child: Text('الحلقات')),
                const Center(child: Text('الاحصائيات')),
                const Center(child: Text('الشخصيات')),
              ],
            )
          ],
        ));
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.favorite_border),
      onPressed: () {},
    );
  }
}

class OptionsAction extends StatelessWidget {
  const OptionsAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: Text('Report Issue'),
          ),
          const PopupMenuItem(
            child: Text('Share'),
          ),
        ];
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

class StatsSection extends StatelessWidget {
  const StatsSection({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: ReviewersWidget(anime: anime)),
          Expanded(child: ReviewersWidget(anime: anime, isGlobal: true)),
          const Expanded(
              child: AddButton(
            text: 'اضافة تقييم',
            icon: Icons.star_border_outlined,
          )),
          const Expanded(
              child: AddButton(
            text: 'قائمتي',
            icon: Icons.add,
          )),
        ],
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 30,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
