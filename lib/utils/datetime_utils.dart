import 'package:intl/intl.dart';

class DateTimeUtils {
  static String convertToDateString(String input,
      {String inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
      String outputFormat = "dd-MM-yyyy"}) {
    String result = "";
    try {
      DateTime parseDate = new DateFormat(inputFormat).parse(input, true);
      result = DateFormat(outputFormat).format(parseDate.toLocal());
    } catch (e) {
      result = "";
    }
    return result;
  }

  static String convertToDateTimeString(String input,
      {String inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
      String outputFormat = "dd-MM-yyyy HH:mm"}) {
    String result = "";
    try {
      DateTime parseDate = new DateFormat(inputFormat).parse(input);
      result = DateFormat(outputFormat).format(parseDate.toLocal());
    } catch (e) {
      result = "";
    }
    return result;
  }

  static String convertDateToCorrectFormat(String input,
      {String inputFormat = "dd/MM/yyyy", String outputFormat = "yyyy-MM-dd"}) {
    String result = "";
    try {
      DateTime parseDate = new DateFormat(inputFormat).parse(input);
      result = DateFormat(outputFormat).format(parseDate.toLocal());
    } catch (e) {
      result = "";
    }
    return result;
  }

  static String convertTimestampToDateString(int timestamp,
      {String outputFormat = "dd/MM/yyyy"}) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat(outputFormat).format(date.toLocal());
  }
}
