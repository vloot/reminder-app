import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/theme.dart';

final orangeLightTheme = AppTheme(
  brightness: Brightness.light,
  primaryColor: Colors.orange,
  primaryColorAccent: Colors.orangeAccent,
  secondaryColor: Colors.white,
  secondaryColorAccent: const Color.fromARGB(255, 208, 208, 208),
  activeColor: Colors.green,
  inactiveColor: Colors.blueGrey,
  warningColor: Colors.redAccent,
  backgroundColor: Color.fromARGB(255, 253, 243, 242),
  backgroundOverlayColor: Color.fromARGB(255, 253, 243, 242),
  textColor: Colors.black,
  transparent: Colors.transparent,
  shadowColor: Colors.black45,
);

final orangeDarkTheme = AppTheme(
  brightness: Brightness.dark,
  primaryColor: Colors.orange,
  primaryColorAccent: Colors.orangeAccent,
  secondaryColor: const Color.fromARGB(255, 22, 22, 22),
  secondaryColorAccent: const Color.fromARGB(255, 105, 105, 105),
  activeColor: const Color.fromARGB(255, 51, 118, 53),
  inactiveColor: Colors.blueGrey,
  warningColor: Colors.redAccent,
  backgroundColor: Colors.black,
  backgroundOverlayColor: const Color.fromARGB(255, 20, 20, 20),
  textColor: const Color.fromARGB(255, 211, 218, 217),
  transparent: Colors.transparent,
  shadowColor: Colors.black54,
);

AppTheme currentTheme = orangeLightTheme;
// AppTheme currentTheme = orangeDarkTheme;
