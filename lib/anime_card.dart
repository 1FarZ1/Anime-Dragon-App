import 'package:anime_slayer/anime_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimeCard extends StatelessWidget {
  const AnimeCard({super.key, required this.anime});

  final AnimeModel anime;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: anime.imageUrl,
            width: 100.w,
            height: 150.h,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                //container with width and height and grey
                Container(
              width: 100.w,
              height: 150.h,
              color: Colors.grey[300],
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          5.verticalSpace,
          // make the title only in 1 line , and if  is more then use overflow ellipsis
          Text(
            anime.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
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
              5.horizontalSpace,
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
          )
        ],
      ),
    );
  }
}
