import 'package:anime_slayer/anime_controller.dart';
import 'package:anime_slayer/anime_model.dart';
import 'package:anime_slayer/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimeDetaillsScreen extends ConsumerWidget {
  const AnimeDetaillsScreen({super.key, required this.animeId});

  final int animeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final anime = ref.watch(singleAnimeProvider(animeId));
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            anime!.title,
            style: TextStyle(
              fontSize: 22.sp,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('Report Issue'),
                  ),
                  const PopupMenuItem(
                    child: Text('Share'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const TopView(),
            10.verticalSpace,
            Header(anime: anime),
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: ReviewersWidget(anime: anime)),
                  Expanded(
                      child: ReviewersWidget(anime: anime, isGlobal: true)),
                  const Expanded(
                      child: AddButton(
                    text: 'اضافة تقييم',
                    icon: Icons.star_border_outlined,
                  )),
                  const Expanded(
                      child: AddButton(
                    text: 'قائمتي',
                    icon: Icons.add,
                  )),
                ],
              ),
            )
          ],
        ));
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 30,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

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

class Header extends StatelessWidget {
  const Header({
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

class TopView extends StatelessWidget {
  const TopView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: DefaultTabController(
        length: 4,
        child: Column(children: [
          TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            unselectedLabelStyle: TextStyle(
              fontSize: 16.sp,
            ),
            labelPadding: EdgeInsets.zero,
            tabs: const [
              Tab(
                text: 'التفاصيل',
              ),
              Tab(
                text: 'الحلقات',
              ),
              Tab(
                text: 'الاحصائيات',
              ),
              Tab(
                text: 'الشخصيات',
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
