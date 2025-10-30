import 'package:intl/intl.dart';

String capitalizeEachWord(String text) {
  return text
      .split(' ')
      .map(
        (word) =>
            word.isEmpty
                ? word
                : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
      )
      .join(' ');
}

extension DateTimeNow on DateTime {
  DateTime get dateOnly {
    return DateTime(year, month, day);
  }
}

extension IntDateFormat on int {
  String get formattedDate {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    return DateFormat("dd\nMMM").format(date);
  }
}
