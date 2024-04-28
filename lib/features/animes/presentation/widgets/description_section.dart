import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'descrption_info_column.dart';
import 'info_item.dart';
import 'tags_view.dart';

class DescriptionSection extends HookWidget {
  DescriptionSection({
    super.key,
    required this.anime,
  });

  final AnimeModel anime;
  final tags = [
    'اكشن',
    'مغامرة',
    'كوميدي',
    'دراما',
    'خيال',
    'شونين',
    'دراما',
    'خيال',
    'شونين',
    'دراما',
    'خيال',
    'شونين',
    'دراما',
    'خيال',
    'شونين',
    'دراما',
    'خيال',
    'شونين',
  ];
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
          GestureDetector(
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
            child: RichText(
              text: TextSpan(
                text: !isExpanded.value && anime.description.length > 200
                    ? anime.description.substring(0, 200)
                    : anime.description,
                children: [
                  TextSpan(
                    text: isExpanded.value ? "" : "...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          10.verticalSpace,
          TagsView(tags: tags),
          5.verticalSpace,
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DescrptionInfoColumn(
                  items: [
                    const InfoItem(name: 'المصدر', value: 'مانجا'),
                    10.verticalSpace,
                    const InfoItem(name: 'عرض من', value: '2024-04-01'),
                    10.verticalSpace,
                    InfoItem(
                      name: 'الاستديو',
                      valueChild: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: AppColors.containerColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text('Studio Pierrot',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ))),
                    ),
                  ],
                ),
                20.horizontalSpace,
                // anime.episodes.length
                10.horizontalSpace,
                DescrptionInfoColumn(items: [
                  const InfoItem(name: 'عدد الحلقات', value: '220'),
                  10.verticalSpace,
                  const InfoItem(name: 'الى', value: '?'),
                  10.verticalSpace,
                  const InfoItem(name: ' العنوان بالانجليزي', value: 'Naruto'),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
