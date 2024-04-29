import 'package:anime_slayer/extensions/stings.dart';
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
  String getMinimazedText(String text) {
    // if  the last world is half a word then remove it
    if (text.length > 200) {
      final lastWord = text.substring(200).split(' ')[0];
      if (lastWord.length < 3) {
        return text.substring(0, 200 - lastWord.length);
      }
    }
    return text.substring(0, 200);
  }

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
        children: [
          GestureDetector(
            onTap: () {
              isExpanded.value = !isExpanded.value;
            },
            child: RichText(
              textDirection: TextDirection.rtl,
              text: TextSpan(
                text: !isExpanded.value && anime.description.length > 200
                    ? getMinimazedText(anime.description)
                    : anime.description,
                children: [
                  TextSpan(
                    text: isExpanded.value ? "" : "...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
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
                    InfoItem(name: 'المصدر', value: anime.source),
                    10.verticalSpace,
                    InfoItem(
                        name: 'عرض من', value: anime.releaseDate.toSimpleDate),
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
                  InfoItem(
                      name: 'عدد الحلقات', value: anime.lastEpisode.toString()),
                  10.verticalSpace,
                  const InfoItem(name: 'الى', value: '?'),
                  10.verticalSpace,
                  InfoItem(
                    name: ' العنوان بالانجليزي',
                    value: anime.title,
                    haveConstrainedDim: true,
                  ),
                ])
              ],
            ),
          ),
        ],
      ),
    );
  }
}
