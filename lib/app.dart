import 'package:anime_slayer/colors.dart';
import 'package:anime_slayer/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/episode/watch_episode_screen.dart';

class AnimeSlayer extends StatelessWidget {
  const AnimeSlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
              title: 'Anime Slayer',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
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
              home: const MainView());
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
