import 'package:anime_slayer/features/animes/presentation/logic/anime_controller.dart';
import 'package:anime_slayer/features/animes/presentation/widgets/add_button.dart';
import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteButton extends HookConsumerWidget {
  const FavoriteButton({
    super.key,
    // required this.isPressedInitial,
    required this.animeId,
    required this.canAdd,
  });

  final int animeId;
  final bool canAdd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref
        .watch(animesControllerProvider)
        .animes
        .asData!
        .value
        .firstWhere((element) => element.id == animeId)
        .isFavorite;

    return IconButton(
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
      onPressed: () {
        if (!canAdd) {
          authGuarder(context);
          return;
        }

        if (!isFav) {
          ref.read(favoriteAnimesController.notifier).addFavoriteAnime(animeId);
        } else {
          ref
              .read(favoriteAnimesController.notifier)
              .removeFavoriteAnime(animeId);
        }
        ref.read(animesControllerProvider.notifier).toggleFavorite(animeId);
      },
    );
  }
}
