import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class User {
  final String name;
  final String email;
  final String avatar;

  User({
    required this.name,
    required this.email,
    required this.avatar,
  });
}

final userProvider = StateProvider<User?>((ref) => null);

class AnimeDrawer extends ConsumerWidget {
  const AnimeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const image =
        'https://scontent.faae2-1.fna.fbcdn.net/v/t39.30808-1/337020160_610296593855142_1884214932119732726_n.jpg?stp=dst-jpg_p160x160&_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_ohc=KGyyFWdATy8Q7kNvgE7JaDZ&_nc_ht=scontent.faae2-1.fna&oh=00_AfD6qSc6AyAniMFxgNWZPWL2YEH4eKeWZ2sabNVFsogjfQ&oe=66344D0F';
    return Drawer(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              // if user is logged in
              if (ref.watch(userProvider) != null) {
                // context.pushNamed(AppRoutes.profile.name);
                ref.read(userProvider.notifier).update((state) => null);
              } else {
                ref.read(userProvider.notifier).update((state) => User(
                      name: 'محمد',
                      email: 'fbekkouche149@gmail.com',
                      avatar: image,
                    ));
                // context.pushNamed(AppRoutes.auth.name);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // if logged in show user avatar
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: ref.watch(userProvider) != null
                        ? (const NetworkImage(image) as ImageProvider<Object>)
                        : const AssetImage('assets/default.png'),
                  ),
                  10.verticalSpace,
                  Text(
                    ref.watch(userProvider) != null
                        ? ref.watch(userProvider)!.name
                        : 'تسجيل الدخول',
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
            title: const Text('اخر التحديثات'),
            onTap: () {
              context.goNamed(AppRoutes.home.name);
            },
            leading: const Icon(Icons.update),
            // title on left
          ),
          ListTile(
            title: const Text('المفضلة'),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil('/favorites', (route) => false);
            },
            leading: const Icon(Icons.favorite),
          ),
          ListTile(
            title: const Text('قائمتي'),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil('/updates', (route) => false);
            },
            leading: const Icon(Icons.list),
          ),
          ListTile(
            title: const Text('الاعدادات'),
            onTap: () {
              // Navigator.of(context).pushNamedAndRemoveUntil('/settings', (route) => false);
            },
            leading: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
