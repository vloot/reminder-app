import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/theme.dart';

final orangeLightTheme = AppTheme(
  primaryColor: Colors.orange,
  primaryColorAccent: Colors.orangeAccent,
  secondaryColor: Colors.white,
  activeColor: Colors.green,
  inactiveColor: Colors.blueGrey,
  warningColor: Colors.redAccent,
  backgroundColor: Color.from(alpha: 1, red: 95, green: 0.95, blue: 0.95),
  textColor: Colors.black,
);

AppTheme currentTheme = orangeLightTheme;
