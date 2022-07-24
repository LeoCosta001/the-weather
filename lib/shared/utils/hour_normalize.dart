class HourNormalize {
  String onlyHour(int dateInMilliseconds) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInMilliseconds);
    return '${date.hour > 9 ? date.hour : '0${date.hour}'}:00';
  }

  String hourAndMinutes(int dateInMilliseconds) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(dateInMilliseconds);
    final String hour = '${date.hour > 9 ? date.hour : '0${date.hour}'}';
    final String minute = '${date.minute > 9 ? date.minute : '0${date.minute}'}';
    return '$hour:$minute';
  }
}
