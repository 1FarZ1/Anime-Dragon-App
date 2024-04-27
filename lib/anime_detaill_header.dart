import 'package:anime_slayer/anime_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimeDetaillHeader extends StatelessWidget {
  const AnimeDetaillHeader({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 120.w,
            height: 140.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              image: DecorationImage(
                image: NetworkImage(anime.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          20.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 140.w,
                child: Text(
                  anime.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                anime.isEnded ? 'منتهي' : 'مستمر',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              5.verticalSpace,
              Text(
                'ربيع 2024',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              5.verticalSpace,
              Text(
                'مسلسل | +13',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
              20.verticalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
