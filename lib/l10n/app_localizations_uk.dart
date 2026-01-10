// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get allReminders => 'Всі';

  @override
  String get selectedOnly => 'Лише обрані';

  @override
  String get addReminder => 'Додати нагадування';

  @override
  String get editReminder => 'Редагування';

  @override
  String get inputTitle => 'Назва';

  @override
  String get inputDescription => 'Опис';

  @override
  String get save => 'Зберегти';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get remindersTitle => 'Нагадування';

  @override
  String reminderCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count нагадувань',
      one: '1 нагадування',
      zero: 'Немає нагадувань',
    );
    return '$_temp0';
  }

  @override
  String get monday => 'Понеділок';

  @override
  String get tuesday => 'Вівторок';

  @override
  String get wednesday => 'Середа';

  @override
  String get thursday => 'Четвер';

  @override
  String get friday => 'П\'ятниця';

  @override
  String get saturday => 'Субона';

  @override
  String get sunday => 'Неділя';

  @override
  String get mondayAbbr => 'пн';

  @override
  String get tuesdayAbbr => 'вт';

  @override
  String get wednesdayAbbr => 'ср';

  @override
  String get thursdayAbbr => 'чт';

  @override
  String get fridayAbbr => 'пт';

  @override
  String get saturdayAbbr => 'сб';

  @override
  String get sundayAbbr => 'нд';

  @override
  String get settingsCustomization => 'Персоналізація';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsFirstDay => 'Перший день';

  @override
  String get settingsTimeFormat => 'Формат часу';

  @override
  String get settingsLang => 'Мова';

  @override
  String get settingsAbout => 'Про додаток';

  @override
  String get settingsSourceCode => 'Код';

  @override
  String get settingsAppVersion => 'Версія';

  @override
  String get settingsOpenRepo => 'Репозиторій';

  @override
  String get themeLight => 'Світла';

  @override
  String get themeDark => 'Темна';

  @override
  String get deleteTitle => 'Видалити нагадування?';

  @override
  String get delete => 'Видалити';

  @override
  String get cancel => 'Скасувати';
}
