import 'dart:io';

import 'package:anime_slayer/features/auth/presentation/user_notifier.dart';

import 'app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/shared_pref.dart';

final appStartupProvider = FutureProvider<void>((ref) async {
  ref.onDispose(() {
    ref.invalidate(sharedPrefProvider);
  });
  await ref.watch(sharedPrefProvider.future);
  await ref.watch(userProvider.notifier).getUser();
});

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    // initImages(context);
    return appStartupState.when(
      loading: () => const AppStartupLoadingWidget(),
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () {
          ref.invalidate(appStartupProvider);
        },
        onClose: () => exit(0),
      ),
      data: (_) => const AnimeSlayer(),
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 12),
          Text('Loading...'),
        ],
      )),
    );
  }
}

class AppStartupErrorWidget extends ConsumerWidget {
  final String message;
  final VoidCallback onRetry;
  final VoidCallback onClose;

  const AppStartupErrorWidget({
    required this.message,
    required this.onRetry,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $message'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onClose,
                child: const Text('Close'),
              ),
            ],
          ),
        ));
  }
}

// void initImages(context) async {
//   await precacheImage(const AssetImage(AppAssets.splashBG), context);
//   await precacheImage(const AssetImage(AppAssets.worldCup), context);
//   await precacheImage(const AssetImage(AppAssets.stadiumBG), context);
//   await precacheImage(const AssetImage(AppAssets.logo), context);
// }
