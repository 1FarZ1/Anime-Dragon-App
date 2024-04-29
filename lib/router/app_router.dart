import 'package:anime_slayer/features/animes/presentation/anime_detaills_screen.dart';
import 'package:anime_slayer/features/animes/presentation/search_view.dart';
import 'package:anime_slayer/features/auth/presentation/auth_screen.dart';
import 'package:anime_slayer/features/main_view.dart';
import 'package:anime_slayer/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'interfaces.dart';

enum AppRoutes {
  home,
  splash,
  search,
  animeDetails,
  watchEpisode,
  favorite,
  myList,
  settings,
  profile,
  auth
}

final isDarkProvider = StateProvider<bool>((ref) => false);

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        path: '/home',
        name: AppRoutes.home.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: MainView());
        },
      ),
      GoRoute(
        path: '/search',
        name: AppRoutes.search.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: SearchAnimeView());
        },
      ),
      GoRoute(
        path: '/auth',
        name: AppRoutes.auth.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: AuthScreen());
        },
      ),
      GoRoute(
        path: '/animeDetails',
        name: AppRoutes.animeDetails.name,
        pageBuilder: (context, state) {
          final animeId = state.extra! as int ;
          return  MaterialPage(
              child: AnimeDetaillsScreen(
            animeId: animeId,
          ));
        },
      ),
      GoRoute(
        path: '/watchEpisode',
        name: AppRoutes.watchEpisode.name,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
    ],
  );
});
