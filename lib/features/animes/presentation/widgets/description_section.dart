import 'package:anime_slayer/features/animes/domaine/anime_model.dart';
import 'package:anime_slayer/consts/colors.dart';
import 'package:flutter/cupertino.dart';
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
          //TODO: add see more button
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

class DescrptionInfoColumn extends StatelessWidget {
  const DescrptionInfoColumn({
    super.key,
    required this.items,
  });

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}

// information item widget , column with name and value
class InfoItem extends StatelessWidget {
  const InfoItem({super.key, required this.name, this.value, this.valueChild})
      : assert(value != null || valueChild != null);

  final String name;
  final String? value;
  final Widget? valueChild;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        5.verticalSpace,
        value != null
            ? Text(
                value!,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            : valueChild!,
      ],
    );
  }
}

class TagsView extends StatelessWidget {
  const TagsView({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 40.h,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            ...tags.map((e) {
              return Container(
                alignment: Alignment.center,
                width: 50.w,
                margin: EdgeInsets.only(right: 5.w, bottom: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xff3A424D),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  e,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
