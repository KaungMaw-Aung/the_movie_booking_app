class DateVO {

  String day;
  String daysOfMonth;
  String date;
  bool isSelected;

  DateVO(this.day, this.daysOfMonth, this.date, this.isSelected);


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateVO &&
          runtimeType == other.runtimeType &&
          day == other.day &&
          daysOfMonth == other.daysOfMonth &&
          date == other.date &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      day.hashCode ^ daysOfMonth.hashCode ^ date.hashCode ^ isSelected.hashCode;

  @override
  String toString() {
    return 'DateVO{day: $day, daysOfMonth: $daysOfMonth, date: $date, isSelected: $isSelected}';
  }
}