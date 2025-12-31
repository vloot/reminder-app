import 'package:reminders_app/core/shared/time_format.dart';
import 'package:reminders_app/core/shared/weekday_info.dart';
import 'package:reminders_app/features/settings/data/models/app_theme_model.dart';
import 'package:reminders_app/features/settings/data/storage/app_settings_keys.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';

class AppSettingsModel {
  final int appBrightness;
  final int timeFormatIndex;
  final int startingDayIndex;
  final AppThemeModel theme;

  static final defaultSettings = AppSettingsModel(
    appBrightness: AppBrightness.light.index,
    timeFormatIndex: TimeFormat.h24.index,
    startingDayIndex: StartingDay.monday.index,
    theme: AppThemeModel.defaultSettingsLight,
  );

  AppSettingsModel({
    required this.appBrightness,
    required this.timeFormatIndex,
    required this.startingDayIndex,
    required this.theme,
  });

  /// MODEL → ENTITY
  AppSettingsEntity toEntity() {
    return AppSettingsEntity(
      appBrightness: AppBrightness.values[appBrightness],
      timeFormat: TimeFormat.values[timeFormatIndex],
      startingDay: StartingDay.values[startingDayIndex],
      theme: theme.toEntity(),
    );
  }

  /// ENTITY → MODEL
  factory AppSettingsModel.fromEntity(AppSettingsEntity e) {
    return AppSettingsModel(
      appBrightness: e.appBrightness.index,
      timeFormatIndex: e.timeFormat.index,
      startingDayIndex: e.startingDay.index,
      theme: AppThemeModel.fromEntity(e.theme),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppSettingsKeys.themeType: appBrightness,
      AppSettingsKeys.timeFormat: timeFormatIndex,
      AppSettingsKeys.startingDay: startingDayIndex,
      AppSettingsKeys.themeSettings: theme.toJson(),
    };
  }

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      appBrightness: json[AppSettingsKeys.themeType],
      timeFormatIndex: json[AppSettingsKeys.timeFormat],
      startingDayIndex: json[AppSettingsKeys.startingDay],
      theme: AppThemeModel.fromJson(
        json[AppSettingsKeys.themeSettings] as Map<String, dynamic>,
      ),
    );
  }
}
