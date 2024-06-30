import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/router/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/interfaces.dart';
import '../anime_detaills_screen.dart';

class AnimeListCard extends StatelessWidget {
  const AnimeListCard({super.key, required this.anime});

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.animeDetails.name, extra: anime.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: anime.imageUrl,
                width: 100.w,
                height: 120.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 100.w,
                  height: 150.h,
                  color: Colors.grey[300],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      anime.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    5.verticalSpace,
                    Text(
                      '${anime.lastEpisode} : حلقة',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        Text(
                          !anime.isEnded ? 'مستمر' : 'منتهي',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        10.horizontalSpace,
                        Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 14.r,
                        ),
                        5.horizontalSpace,
                        Text(
                          anime.rating.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
