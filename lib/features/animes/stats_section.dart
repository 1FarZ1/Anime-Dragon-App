import 'package:anime_slayer/features/animes/presentation/anime_detaills_screen.dart';
import 'package:anime_slayer/features/animes/presentation/anime_model.dart';
import 'package:anime_slayer/features/animes/presentation/reviewers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../add_button.dart';

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
