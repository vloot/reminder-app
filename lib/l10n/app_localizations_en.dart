// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get allReminders => 'All';

  @override
  String get selectedOnly => 'Selected only';

  @override
  String get addReminder => 'Add reminder';

  @override
  String get editReminder => 'Edit reminder';

  @override
  String get inputTitle => 'Title';

  @override
  String get inputDescription => 'Description';

  @override
  String get save => 'Save';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get remindersTitle => 'Reminders';

  @override
  String reminderCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reminders',
      one: '1 reminder',
      zero: 'No reminders',
    );
    return '$_temp0';
  }

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get mondayAbbr => 'mon';

  @override
  String get tuesdayAbbr => 'tue';

  @override
  String get wednesdayAbbr => 'wed';

  @override
  String get thursdayAbbr => 'thu';

  @override
  String get fridayAbbr => 'fri';

  @override
  String get saturdayAbbr => 'sat';

  @override
  String get sundayAbbr => 'sun';

  @override
  String get settingsCustomization => 'Customization';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsFirstDay => 'First day';

  @override
  String get settingsTimeFormat => 'Time format';

  @override
  String get settingsLang => 'Language';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsSourceCode => 'Source code';

  @override
  String get settingsAppVersion => 'App version';

  @override
  String get settingsOpenRepo => 'Open repo';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get deleteTitle => 'Delete reminder?';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';
}
