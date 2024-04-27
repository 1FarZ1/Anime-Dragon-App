import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.favorite_border),
      onPressed: () {},
    );
  }
}
