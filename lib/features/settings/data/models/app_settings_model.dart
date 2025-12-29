import 'package:flutter/material.dart';
import 'package:reminders_app/features/settings/data/storage/app_settings_keys.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';

class AppSettingsModel {
  final int appBrightness;
  final int timeFormatIndex;
  final int startingDayIndex;

  final int primaryColor;
  final int primaryColorAccent;
  final int secondaryColor;
  final int secondaryColorAccent;
  final int activeColor;
  final int inactiveColor;
  final int warningColor;
  final int backgroundColor;
  final int backgroundOverlayColor;
  final int textColor;
  final int transparent;
  final int shadowColor;

  static final defaultSettingsLight = AppSettingsModel(
    appBrightness: AppBrightness.light.index,
    timeFormatIndex: TimeFormat.h24.index,
    startingDayIndex: StartingDay.monday.index,
    primaryColor: Colors.orange.toARGB32(),
    primaryColorAccent: Colors.orangeAccent.toARGB32(),
    secondaryColor: Colors.white.toARGB32(),
    secondaryColorAccent: const Color.fromARGB(255, 208, 208, 208).toARGB32(),
    activeColor: Colors.green.toARGB32(),
    inactiveColor: Colors.blueGrey.toARGB32(),
    warningColor: Colors.redAccent.toARGB32(),
    backgroundColor: Color.fromARGB(255, 253, 243, 242).toARGB32(),
    backgroundOverlayColor: Color.fromARGB(255, 253, 243, 242).toARGB32(),
    textColor: Colors.black.toARGB32(),
    transparent: Colors.transparent.toARGB32(),
    shadowColor: Colors.black45.toARGB32(),
  );

  static final defaultSettingsDark = AppSettingsModel(
    appBrightness: AppBrightness.dark.index,
    timeFormatIndex: TimeFormat.h24.index,
    startingDayIndex: StartingDay.monday.index,
    primaryColor: Colors.orange.toARGB32(),
    primaryColorAccent: Colors.orangeAccent.toARGB32(),
    secondaryColor: const Color.fromARGB(255, 22, 22, 22).toARGB32(),
    secondaryColorAccent: const Color.fromARGB(255, 105, 105, 105).toARGB32(),
    activeColor: const Color.fromARGB(255, 51, 118, 53).toARGB32(),
    inactiveColor: Colors.blueGrey.toARGB32(),
    warningColor: Colors.redAccent.toARGB32(),
    backgroundColor: Colors.black.toARGB32(),
    backgroundOverlayColor: const Color.fromARGB(255, 20, 20, 20).toARGB32(),
    textColor: const Color.fromARGB(255, 211, 218, 217).toARGB32(),
    transparent: Colors.transparent.toARGB32(),
    shadowColor: Colors.black54.toARGB32(),
  );

  AppSettingsModel({
    required this.appBrightness,
    required this.timeFormatIndex,
    required this.startingDayIndex,
    required this.primaryColor,
    required this.primaryColorAccent,
    required this.secondaryColor,
    required this.secondaryColorAccent,
    required this.activeColor,
    required this.inactiveColor,
    required this.warningColor,
    required this.backgroundColor,
    required this.backgroundOverlayColor,
    required this.textColor,
    required this.transparent,
    required this.shadowColor,
  });

  /// MODEL → ENTITY
  AppSettingsEntity toEntity() {
    return AppSettingsEntity(
      appBrightness: AppBrightness.values[appBrightness],
      timeFormat: TimeFormat.values[timeFormatIndex],
      startingDay: StartingDay.values[startingDayIndex],
      primaryColor: primaryColor,
      primaryColorAccent: primaryColorAccent,
      secondaryColor: secondaryColor,
      secondaryColorAccent: secondaryColorAccent,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      warningColor: warningColor,
      backgroundColor: backgroundColor,
      backgroundOverlayColor: backgroundOverlayColor,
      textColor: textColor,
      transparent: transparent,
      shadowColor: shadowColor,
    );
  }

  /// ENTITY → MODEL
  factory AppSettingsModel.fromEntity(AppSettingsEntity e) {
    return AppSettingsModel(
      appBrightness: e.appBrightness.index,
      timeFormatIndex: e.timeFormat.index,
      startingDayIndex: e.startingDay.index,
      primaryColor: e.primaryColor,
      primaryColorAccent: e.primaryColorAccent,
      secondaryColor: e.secondaryColor,
      secondaryColorAccent: e.secondaryColorAccent,
      activeColor: e.activeColor,
      inactiveColor: e.inactiveColor,
      warningColor: e.warningColor,
      backgroundColor: e.backgroundColor,
      backgroundOverlayColor: e.backgroundOverlayColor,
      textColor: e.textColor,
      transparent: e.transparent,
      shadowColor: e.shadowColor,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppSettingsKeys.themeType: appBrightness,
      AppSettingsKeys.timeFormat: timeFormatIndex,
      AppSettingsKeys.startingDay: startingDayIndex,
      AppSettingsKeys.primaryColor: primaryColor,
      AppSettingsKeys.primaryColorAccent: primaryColorAccent,
      AppSettingsKeys.secondaryColor: secondaryColor,
      AppSettingsKeys.secondaryColorAccent: secondaryColorAccent,
      AppSettingsKeys.activeColor: activeColor,
      AppSettingsKeys.inactiveColor: inactiveColor,
      AppSettingsKeys.warningColor: warningColor,
      AppSettingsKeys.backgroundColor: backgroundColor,
      AppSettingsKeys.backgroundOverlayColor: backgroundOverlayColor,
      AppSettingsKeys.textColor: textColor,
      AppSettingsKeys.transparent: transparent,
      AppSettingsKeys.shadowColor: shadowColor,
    };
  }

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      appBrightness: json[AppSettingsKeys.themeType],
      timeFormatIndex: json[AppSettingsKeys.timeFormat],
      startingDayIndex: json[AppSettingsKeys.startingDay],
      primaryColor: json[AppSettingsKeys.primaryColor],
      primaryColorAccent: json[AppSettingsKeys.primaryColorAccent],
      secondaryColor: json[AppSettingsKeys.secondaryColor],
      secondaryColorAccent: json[AppSettingsKeys.secondaryColorAccent],
      activeColor: json[AppSettingsKeys.activeColor],
      inactiveColor: json[AppSettingsKeys.inactiveColor],
      warningColor: json[AppSettingsKeys.warningColor],
      backgroundColor: json[AppSettingsKeys.backgroundColor],
      backgroundOverlayColor: json[AppSettingsKeys.backgroundOverlayColor],
      textColor: json[AppSettingsKeys.textColor],
      transparent: json[AppSettingsKeys.transparent],
      shadowColor: json[AppSettingsKeys.shadowColor],
    );
  }
}
