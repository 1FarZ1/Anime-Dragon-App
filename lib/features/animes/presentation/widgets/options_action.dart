import 'package:flutter/material.dart';

class OptionsAction extends StatelessWidget {
  const OptionsAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            child: Text('Report Issue'),
          ),
          const PopupMenuItem(
            child: Text('Share'),
          ),
        ];
      },
    );
  }
}
