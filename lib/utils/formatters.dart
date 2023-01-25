String getWeekday(int day) {
  switch (day) {
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thur";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    case 7:
      return "Sun";
    default:
      return "";
  }
}

DateTime getDateFormat(String? date, {bool split = true}) {
  print("DATE $date");
  if (date == null) {
    return DateTime.now();
  }
  if (split) {
    return DateTime.parse(
        "${date.split('-')[2]}-${date.split('-')[1]}-${date.split('-')[0]}");
  } else {
    return DateTime.parse(date);
  }
}
