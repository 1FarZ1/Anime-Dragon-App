import 'package:anime_slayer/consts/colors.dart';
import 'package:anime_slayer/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimeSlayer extends ConsumerWidget {
  const AnimeSlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: MaterialApp.router(
              routerConfig: ref.watch(appRouterProvider),
              title: 'Anime Slayer',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // direction of text

                brightness: Brightness.dark,
                primaryColor: Colors.black,
                scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
                appBarTheme: const AppBarTheme(
                  backgroundColor: //dark blue
                      AppColors.primaryColor,
                ),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Colors.black,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                ),
              ),
            ),
          );
        });
  }
}

// class DebugScreen extends StatelessWidget {
//   const DebugScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: WatchEpisodeScreen(),
//     );
//   }
// }
