import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/infrastructure/dependency_injection.dart';
import 'package:reminders_app/core/shared/weekday_info.dart';
import 'package:reminders_app/features/reminder/presentation/reminders_list/reminders_page.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_bloc.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reminders_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<AppSettingsBloc>())],
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.settings.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [Locale('en'), Locale('uk')],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color(state.settings.theme.primaryColor),
                brightness: state.settings.appBrightness == AppBrightness.light
                    ? Brightness.light
                    : Brightness.dark,
              ),
            ),
            home: Builder(
              builder: (context) {
                createWeekdays(AppLocalizations.of(context)!);
                return RemindersPage();
              },
            ),
          );
        },
      ),
    ),
  );
}
