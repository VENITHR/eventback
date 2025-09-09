import 'package:intl/intl.dart';

class CustomDateFormat {
  String formattedDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0'); // ensures 01, 02, etc.
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  String formatUtcToLocal(String utcDateStr) {
    DateTime utcDate = DateTime.parse(utcDateStr);
    DateTime localDate = utcDate.toLocal();

    return DateFormat('dd MMM yyyy hh:mm a').format(localDate);
  }
}
