import 'package:flutter/cupertino.dart';

class DescrptionInfoColumn extends StatelessWidget {
  const DescrptionInfoColumn({
    super.key,
    required this.items,
  });

  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}
