// 2015-08-07

// extension methods for String to convert above date to format such as Aug 7, 2015

import 'package:intl/intl.dart';

extension DateExtension on String {
  String get toMonthDayYear {
    var date = DateTime.parse(this);
    var formatter = DateFormat('MMM d, yyyy');
    return formatter.format(date);
  }
}
