import 'package:flutter/material.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/core/themes/themes.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: currentTheme.primaryColor,
          brightness: Brightness.light,
        ),
      ),
      home: RemindersPage(),
    ),
  );
}
