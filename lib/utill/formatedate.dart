import 'package:intl/intl.dart';

String formatSmartDate(String date) {
  try {
    DateTime dt = DateTime.parse(date);
    DateTime now = DateTime.now();

    // Get date only
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime taskDay = DateTime(dt.year, dt.month, dt.day);

    String time = DateFormat('hh:mm a').format(dt);

    if (taskDay == today) {
      return "Today • $time";
    } else if (taskDay == today.subtract(Duration(days: 1))) {
      return "Yesterday • $time";
    } else {
      return DateFormat('dd MMM yyyy • hh:mm a').format(dt);
    }
  } catch (e) {
    return date; 
  }
}
