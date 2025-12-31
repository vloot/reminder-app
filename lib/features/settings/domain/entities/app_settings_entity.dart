import 'package:reminders_app/core/shared/time_format.dart';
import 'package:reminders_app/core/shared/weekday_info.dart';
import 'package:reminders_app/features/settings/domain/entities/app_theme_entity.dart';

class AppSettingsEntity {
  final AppBrightness appBrightness;
  final TimeFormat timeFormat;
  final StartingDay startingDay;
  final AppThemeEntity theme;

  AppSettingsEntity({
    required this.appBrightness,
    required this.timeFormat,
    required this.startingDay,
    required this.theme,
  });

  AppSettingsEntity copyWith({
    AppBrightness? appBrightness,
    TimeFormat? timeFormat,
    StartingDay? startingDay,
    AppThemeEntity? theme,
  }) {
    return AppSettingsEntity(
      appBrightness: appBrightness ?? this.appBrightness,
      timeFormat: timeFormat ?? this.timeFormat,
      startingDay: startingDay ?? this.startingDay,
      theme: theme ?? this.theme,
    );
  }
}

enum AppBrightness { system, light, dark, custom }
