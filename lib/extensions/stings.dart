extension X on String {}

extension Y on DateTime {
  String get toSimpleDate => toIso8601String().split('T').first;

  String get timeSaiontime {
    final month = this.month;
    final year = this.year;
    if (month >= 3 && month <= 5) {
      return 'ربيع $year';
    } else if (month >= 6 && month <= 8) {
      return 'صيف $year';
    } else if (month >= 9 && month <= 11) {
      return 'خريف $year';
    } else {
      return 'شتاء $year';
    }
  }
}
