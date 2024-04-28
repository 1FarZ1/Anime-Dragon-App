import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/anime_detaill_header.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/description_section.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainDetaillView extends StatelessWidget {
  const MainDetaillView({super.key, required this.anime});

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AnimeDetaillHeader(anime: anime),
          10.verticalSpace,
          StatsSection(anime: anime),
          10.verticalSpace,
          DescriptionSection(anime: anime),
        ],
      ),
    );
  }
}
