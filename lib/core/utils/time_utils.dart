import 'package:intl/intl.dart';

class TimeUtils {
  static // Function to extract the hour part from the datetime string
      String extractHour(String dateString) {
    // Parse the ISO 8601 string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Return the hour in 'hh a' format (12-hour clock with AM/PM)
    return DateFormat('h a').format(dateTime);
  }
}
