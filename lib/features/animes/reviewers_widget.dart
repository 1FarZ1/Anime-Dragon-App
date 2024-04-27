import 'package:anime_slayer/features/animes/presentation/anime_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewersWidget extends StatelessWidget {
  const ReviewersWidget({
    super.key,
    required this.anime,
    this.isGlobal = false,
  });

  final AnimeModel anime;
  final bool isGlobal;

  @override
  Widget build(BuildContext context) {
    final rating = isGlobal ? 6.89 : anime.rating;
    final reviewers = isGlobal ? 3682 : 1096;

    return Column(
      children: [
        Icon(
          isGlobal ? Icons.video_stable : Icons.star,
          color: Colors.orange,
          size: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$rating',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            // /10
            Text('/10',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                )),
          ],
        ),
        Text(
          '$reviewers',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
