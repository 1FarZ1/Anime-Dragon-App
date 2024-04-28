import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DescriptionSection extends HookWidget {
  DescriptionSection({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;
  final tags = ['اكشن', 'مغامرة', 'كوميدي', 'دراما', 'خيال', 'شونين'];
  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
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
          GestureDetector(
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
            child: RichText(
              text: TextSpan(
                text: !isExpanded.value
                    ? anime.description.substring(0, 50)
                    : anime.description,
            



                children: [
                  TextSpan(
                    text: isExpanded.value ? "" : "...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    //   recognizer: TapGestureRecognizer()
                    //       ..onTap = () => isExpanded.value = !isExpanded.value,
                  ),
                ],
              ),
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




