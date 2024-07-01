import 'dart:developer';

import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/extensions/stings.dart';
import 'package:anime_slayer/router/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/presentation/user_notifier.dart';

enum DrawerOption {
  home,
  favorite,
  myList,
  settings,
}

final currentSelectedDrawerItem =
    StateProvider<DrawerOption>((ref) => DrawerOption.home);

class AnimeDrawer extends HookConsumerWidget {
  const AnimeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final selected = ref.watch(currentSelectedDrawerItem);

    void changeSelectedItem(DrawerOption item) {
      ref.read(currentSelectedDrawerItem.notifier).update((state) => item);
    }

    return Drawer(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              if (user.isLoggedIn) {
                context.pushNamed(AppRoutes.profile.name);
                return;
              }
              context.pushNamed(AppRoutes.auth.name);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: user.isLoggedIn
                        ? (CachedNetworkImageProvider(
                                user.userData!.avatar.toImageUrl)
                            as ImageProvider<Object>)
                        : const AssetImage('assets/default.png'),
                  ),
                  10.verticalSpace,
                  Text(
                    user.userData?.name ?? 'تسجيل الدخول',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            selected: selected == DrawerOption.home,
            title: const Text('اخر التحديثات'),
            onTap: () {
              changeSelectedItem(DrawerOption.home);
              context.goNamed(AppRoutes.home.name);
            },
            leading: const Icon(Icons.update),
            // title on left
          ),
          ListTile(
            selected: selected == DrawerOption.favorite,
            title: Text('المفضلة',
                style: TextStyle(
                  color: user.isLoggedIn
                      ? selected == DrawerOption.favorite
                          ? Colors.deepPurple[100]
                          : Colors.white
                      : Colors.grey,
                )),
            onTap: () {
              if (selected != DrawerOption.favorite && user.isLoggedIn) {
                changeSelectedItem(DrawerOption.favorite);
                context.goNamed(AppRoutes.favorite.name);
              }
            },
            leading: Icon(
              Icons.favorite,
              color: user.isLoggedIn
                  ? selected == DrawerOption.favorite
                      ? Colors.deepPurple[100]
                      : Colors.white
                  : Colors.grey,
            ),
          ),
          ListTile(
            selected: selected == DrawerOption.myList,
            title: Text('قائمتي',
                style: TextStyle(
                  color: user.isLoggedIn
                      ? selected == DrawerOption.myList
                          ? Colors.deepPurple[100]
                          : Colors.white
                      : Colors.grey,
                  // fontWeight: FontWeight.bold,
                )),
            onTap: () {
              if (selected != DrawerOption.myList && user.isLoggedIn) {
                changeSelectedItem(DrawerOption.myList);

                context.goNamed(
                  AppRoutes.myList.name,
                );
              }
            },
            leading: Icon(
              Icons.list,
              color: user.isLoggedIn
                  ? selected == DrawerOption.myList
                      ? Colors.deepPurple[100]
                      : Colors.white
                  : Colors.grey,
            ),
          ),
          ListTile(
            selected: selected == DrawerOption.settings,
            title: const Text('الاعدادات'),
            onTap: () {
              changeSelectedItem(DrawerOption.settings);
              context.goNamed(AppRoutes.settings.name);
            },
            leading: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
