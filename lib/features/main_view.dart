import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/anime_grid.dart';
import 'package:anime_slayer/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MainView extends ConsumerWidget {
  MainView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: const AnimeDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text('اخر التحديثات',
              style: TextStyle(
                fontSize: 18.sp,
              )),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.pushNamed(
                  AppRoutes.search.name,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.grid_view),
              onPressed: () {
                // ref.read(animeViewControllerProvider.notifier).switchView();
              },
            ),
            IconButton(
              icon: const Icon(Icons.report, color: Colors.red),
              onPressed: () {
                // showReportIssue(context);
              },
            ),
          ],
        ),
        body: const Column(
          children: [
            Expanded(child: AnimesView()),
          ],
        ));
  }
}

class AnimeDrawer extends StatelessWidget {
  const AnimeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                10.verticalSpace,
                Text(
                  'اسم المستخدم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('الرئيسية'),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
          ListTile(
            title: const Text('المفضلة'),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil('/favorites', (route) => false);
            },
          ),
          ListTile(
            title: const Text('التحديثات'),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil('/updates', (route) => false);
            },
          ),
          ListTile(
            title: const Text('الاعدادات'),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil('/settings', (route) => false);
            },
          ),
          ListTile(
            title: const Text('تسجيل الخروج'),
            onTap: () {
              // ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}
