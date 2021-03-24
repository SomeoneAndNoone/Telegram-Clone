import 'package:intl/intl.dart';

String getTimeFromDate(int millisecondsSinceEpoch) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  return DateFormat('h:mm a').format(date);
}

String getDMYFromDate(int millisecondsSinceEpoch) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  return '${date.day} ${DateFormat.MMM().format(date)}${date.year != DateTime.now().year ? ', ${date.year}' : ''}';
}

String getMessageDate(int millisecondsSinceEpoch) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  DateTime today = DateTime.now();
  if (date.year == today.year && date.month == today.month && date.day == today.day) {
    return getTimeFromDate(millisecondsSinceEpoch);
  } else {
    return getDMYFromDate(millisecondsSinceEpoch);
  }
}
