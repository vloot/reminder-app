import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';

class WeekdayInfo {
  final Weekday weekday;

  String fullName() => weekday.name;
  String shortName() => weekday.name.substring(0, 3);
  String firstLetter() => weekday.name[0].toUpperCase();

  WeekdayInfo({required this.weekday});
}

var weekdaysInfo = <WeekdayInfo>[
  WeekdayInfo(weekday: Weekday.monday),
  WeekdayInfo(weekday: Weekday.tuesday),
  WeekdayInfo(weekday: Weekday.wednesday),
  WeekdayInfo(weekday: Weekday.thursday),
  WeekdayInfo(weekday: Weekday.friday),
  WeekdayInfo(weekday: Weekday.saturday),
  WeekdayInfo(weekday: Weekday.sunday),
];

List<WeekdayInfo> getOrderedDays(StartingDay startingDay) {
  final startIndex = startingDay == StartingDay.monday ? 0 : 6; // sunday index
  var days = [
    ...weekdaysInfo.sublist(startIndex),
    ...weekdaysInfo.sublist(0, startIndex),
  ];
  return days;
}
