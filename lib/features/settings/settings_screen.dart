import 'package:anime_slayer/features/anime_drawer.dart';
import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';
import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:anime_slayer/features/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animeList/open_drawer_button.dart';
import '../animes/presentation/widgets/anime_grid.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(animesControllerProvider);
    return Scaffold(
      drawer: const AnimeDrawer(),
      appBar: AppBar(
        leading: const OpenDrawerButton(),
        title: const Text('الاعدادات'),
      ),
      body: const Column(),
    );
  }
}
