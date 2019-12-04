import 'package:intl/intl.dart';

class DateUtils {
  static final _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  static String formatLocale(DateTime dateTime) {
    return _dateFormat.format(dateTime ?? '');
  }

  static DateTime getMinTime() {
    return DateTime.now();
  }

  static DateTime getMaxTime() {
    return DateTime.now()..add(Duration(days: 700));
  }
}
