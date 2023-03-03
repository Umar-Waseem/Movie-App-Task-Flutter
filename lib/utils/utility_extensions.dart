// ignore_for_file: unnecessary_null_comparison

import 'package:intl/intl.dart';

extension DateExtension on String {
  String get toMonthDayYear {
    try {
      if (this == null) {
        return '';
      }

      var date = DateTime.parse(this);
      var formatter = DateFormat('MMM d, yyyy');
      return formatter.format(date);
    } catch (e) {
      return this;
    }
  }
}
