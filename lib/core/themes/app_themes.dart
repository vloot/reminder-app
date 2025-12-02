import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/theme.dart';

final orangeLightTheme = AppTheme(
  primaryColor: Colors.orange,
  primaryColorAccent: Colors.orangeAccent,
  secondaryColor: Colors.white,
  secondaryColorAccent: Colors.white,
  activeColor: Colors.green,
  inactiveColor: Colors.blueGrey,
  warningColor: Colors.redAccent,
  backgroundColor: Color.from(alpha: 1, red: 95, green: 0.95, blue: 0.95),
  textColor: Colors.black,
  transparent: Colors.transparent,
  shadowColor: Colors.black45,
);

final orangeDarkTheme = AppTheme(
  primaryColor: Colors.orange,
  primaryColorAccent: Colors.orangeAccent,
  secondaryColor: Colors.black,
  secondaryColorAccent: Colors.black54,
  activeColor: Colors.green,
  inactiveColor: Colors.blueGrey,
  warningColor: Colors.redAccent,
  backgroundColor: Colors.black,
  textColor: Colors.white,
  transparent: Colors.transparent,
  shadowColor: Colors.white24,
);

AppTheme currentTheme = orangeLightTheme;
// AppTheme currentTheme = orangeDarkTheme;
