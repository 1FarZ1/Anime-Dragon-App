import 'package:anime_slayer/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBarView extends StatelessWidget {
  const TopBarView({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Column(children: [
        TabBar(
          controller: tabController,
          onTap: (value) {
            tabController.animateTo(value);
          },
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
    );
  }
}
