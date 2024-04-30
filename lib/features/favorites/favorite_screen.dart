



import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../animes/presentation/widgets/anime_grid.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animes = ref.watch(favoriteAnimesController);
    return AnimesView(animes: animes,);
  }
}