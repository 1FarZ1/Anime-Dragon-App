import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../app_startup.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: AppStartupWidget());
        },
      ),
    ],
  );
});
