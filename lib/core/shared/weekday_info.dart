import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/l10n/app_localizations.dart';

class WeekdayInfo {
  final Weekday weekday;
  final String name;
  final String abbr;

  String fullName() => name;
  String abbreviation() => abbr;
  String firstLetter() => name[0].toUpperCase();

  WeekdayInfo({required this.weekday, required this.name, required this.abbr});
}

var weekdaysInfo = <WeekdayInfo>[];

void createWeekdays(AppLocalizations l10n) {
  weekdaysInfo = [
    WeekdayInfo(
      weekday: Weekday.monday,
      name: l10n.monday,
      abbr: l10n.mondayAbbr,
    ),
    WeekdayInfo(
      weekday: Weekday.tuesday,
      name: l10n.tuesday,
      abbr: l10n.tuesdayAbbr,
    ),
    WeekdayInfo(
      weekday: Weekday.wednesday,
      name: l10n.wednesday,
      abbr: l10n.wednesdayAbbr,
    ),
    WeekdayInfo(
      weekday: Weekday.thursday,
      name: l10n.thursday,
      abbr: l10n.thursdayAbbr,
    ),
    WeekdayInfo(
      weekday: Weekday.friday,
      name: l10n.friday,
      abbr: l10n.fridayAbbr,
    ),
    WeekdayInfo(
      weekday: Weekday.saturday,
      name: l10n.saturday,
      abbr: l10n.saturdayAbbr,
    ),
    WeekdayInfo(
      weekday: Weekday.sunday,
      name: l10n.sunday,
      abbr: l10n.sundayAbbr,
    ),
  ];
}

List<WeekdayInfo> getOrderedDays(StartingDay startingDay) {
  final startIndex = startingDay == StartingDay.monday ? 0 : 6; // sunday index
  var days = [
    ...weekdaysInfo.sublist(startIndex),
    ...weekdaysInfo.sublist(0, startIndex),
  ];
  return days;
}

enum StartingDay { monday, sunday }
