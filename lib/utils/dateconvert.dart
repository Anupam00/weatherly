import 'package:intl/intl.dart';

String getDayName(String date) {
  DateTime parsedDate = DateTime.parse(date);
  return DateFormat('EEEE').format(parsedDate);
}
