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

class AnimeDrawer extends HookConsumerWidget {
  const AnimeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState<DrawerOption>(
      DrawerOption.home,
    );

    final user = ref.watch(userProvider);
    return Drawer(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              if (user.isLoggedIn) {
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
            selected: selected.value == DrawerOption.home,
            title: const Text('اخر التحديثات'),
            onTap: () {
              selected.value = DrawerOption.home;
              context.goNamed(AppRoutes.home.name);
            },
            leading: const Icon(Icons.update),
            // title on left
          ),
          ListTile(
            selected: selected.value == DrawerOption.favorite,
            title: const Text('المفضلة'),
            onTap: () {
              selected.value = DrawerOption.favorite;
              // Navigator.of(context).pushNamedAndRemoveUntil('/favorites', (route) => false);
            },
            leading: const Icon(Icons.favorite),
          ),
          ListTile(
            selected: selected.value == DrawerOption.myList,
            title: const Text('قائمتي'),
            onTap: () {
              selected.value = DrawerOption.myList;
              // Navigator.of(context).pushNamedAndRemoveUntil('/updates', (route) => false);
            },
            leading: const Icon(Icons.list),
          ),
          ListTile(
            selected: selected.value == DrawerOption.settings,
            title: const Text('الاعدادات'),
            onTap: () {
              selected.value = DrawerOption.settings;
              // Navigator.of(context).pushNamedAndRemoveUntil('/settings', (route) => false);
            },
            leading: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
