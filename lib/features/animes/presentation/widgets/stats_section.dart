import 'package:anime_slayer/features/animes/presentation/anime_detaills_screen.dart';
import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/reviewers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/user_notifier.dart';
import 'add_button.dart';

class StatsSection extends ConsumerWidget {
  const StatsSection({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: ReviewersWidget(anime: anime)),
          Expanded(child: ReviewersWidget(anime: anime, isGlobal: true)),
          Expanded(
              child: AddReviewButton(
            text: anime.isReviewed ? 'تعديل التقييم' : 'اضافة تقييم',
            icon: Icons.star_border_outlined,
            animeId: anime.id,
            canAdd: user.isLoggedIn,
          )),
          Expanded(
              child: AddToMyListButton(
            text: 'قائمتي',
            icon: Icons.playlist_add,
            animeId: anime.id,
            canAdd: user.isLoggedIn,
            initialValue: anime.isInMyList,
          )),
        ],
      ),
    );
  }
}


// add fav - >  change local state   