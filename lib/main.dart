import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/features/reminder/presentation/reminder/reminder_page.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_bloc.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();

  runApp(
    BlocProvider(
      create: (_) => getIt<AppSettingsBloc>(),
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(state.settings.primaryColor),
                brightness: state.settings.appBrightness == AppBrightness.light
                    ? Brightness.light
                    : Brightness.dark,
              ),
            ),
            home: RemindersPage(),
          );
        },
      ),
    ),
  );
}
