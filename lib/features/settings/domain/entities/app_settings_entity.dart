class AppSettingsEntity {
  final AppBrightness appBrightness;
  final TimeFormat timeFormat;
  final StartingDay startingDay;

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

  AppSettingsEntity({
    required this.appBrightness,
    required this.timeFormat,
    required this.startingDay,
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

  AppSettingsEntity copyWith({
    AppBrightness? appBrightness,
    TimeFormat? timeFormat,
    StartingDay? startingDay,
    int? primaryColor,
    int? primaryColorAccent,
    int? secondaryColor,
    int? secondaryColorAccent,
    int? activeColor,
    int? inactiveColor,
    int? warningColor,
    int? backgroundColor,
    int? backgroundOverlayColor,
    int? textColor,
    int? transparent,
    int? shadowColor,
  }) {
    return AppSettingsEntity(
      appBrightness: appBrightness ?? this.appBrightness,
      timeFormat: timeFormat ?? this.timeFormat,
      startingDay: startingDay ?? this.startingDay,
      primaryColor: primaryColor ?? this.primaryColor,
      primaryColorAccent: primaryColorAccent ?? this.primaryColorAccent,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      secondaryColorAccent: secondaryColorAccent ?? this.secondaryColorAccent,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      warningColor: warningColor ?? this.warningColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundOverlayColor:
          backgroundOverlayColor ?? this.backgroundOverlayColor,
      textColor: textColor ?? this.textColor,
      transparent: transparent ?? this.transparent,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }
}

enum AppBrightness { system, light, dark, custom }

enum TimeFormat { h24, h12 }

enum StartingDay { monday, sunday }
