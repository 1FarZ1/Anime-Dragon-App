import 'package:flutter/material.dart';

class OpenDrawerButton extends StatelessWidget {
  const OpenDrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    });
  }
}
