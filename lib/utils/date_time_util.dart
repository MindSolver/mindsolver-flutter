bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year && //
      date1.month == date2.month &&
      date1.day == date2.day;
}

extension DateTimeExtension on DateTime {
  bool isAfterDay(DateTime date) {
    final thisDate = DateTime(this.year, this.month, this.day);
    final otherDate = DateTime(date.year, date.month, date.day);
    return thisDate.isAfter(otherDate);
  }

  bool isBeforeOrSameDay(DateTime date) {
    return !this.isAfterDay(date);
  }

  bool isSameYearAndMonth(DateTime date) {
    return this.month == date.month && this.year == date.year;
  }

  bool isSameDate(DateTime date) {
    return this.year == date.year && //
        this.month == date.month &&
        this.day == date.day;
  }

  DateTime trimTime() {
    return DateTime(this.year, this.month, this.day);
  }

  String toFormattedString() {
    return '${this.year}년 ${this.month}월 ${this.day}일';
  }
}