int calculatePassedDays(DateTime date) {
  DateTime currentDate = DateTime.now();
  Duration difference = currentDate.difference(date);
  int daysDifference = difference.inDays;

  return daysDifference;
}
