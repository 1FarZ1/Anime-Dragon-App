import 'package:anime_slayer/features/favorites/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteButton extends HookConsumerWidget {
  const FavoriteButton({
    super.key,
    // required this.isPressedInitial,
    required this.animeId,
  });

  // final bool isPressedInitial;
  final int animeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getInitialValue() {
      final list = ref.watch(favoriteAnimesController).asData?.value ?? [];
      return list.any((element) => element.id == animeId);
    }

    final isPressed = useState(getInitialValue());
    return IconButton(
      icon: Icon(
        isPressed.value ? Icons.favorite : Icons.favorite_border,
        color: Colors.white,
      ),
      onPressed: () {
        isPressed.value = !isPressed.value;
        if (isPressed.value) {
          ref.read(favoriteAnimesController.notifier).addFavoriteAnime(animeId);
        } else {
          ref
              .read(favoriteAnimesController.notifier)
              .removeFavoriteAnime(animeId);
        }
      },
    );
  }
}
