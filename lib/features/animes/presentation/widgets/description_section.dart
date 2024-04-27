import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionSection extends StatelessWidget {
  DescriptionSection({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;
  final tags = ['اكشن', 'مغامرة', 'كوميدي', 'دراما', 'خيال', 'شونين'];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //TODO: add see more button
          Text(
            anime.description,
            maxLines: 5,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),

          5.verticalSpace,
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            textDirection: TextDirection.rtl,
            children: [
              ...tags.map((e) {
                return Container(
                  margin: EdgeInsets.only(right: 5.w, bottom: 10.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xff3A424D),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
