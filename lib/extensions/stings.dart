extension X on String {}

extension Y on DateTime {
  String get toSimpleDate => toIso8601String().split('T').first;
}
