import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/shared/time_format.dart';
import 'package:reminders_app/core/shared/weekday_info.dart';
import 'package:reminders_app/features/settings/data/models/app_theme_model.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_bloc.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_event.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/settings/presentation/widgets/settings_toggle.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      bloc: context.read<AppSettingsBloc>(),
      builder: (context, settingsState) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(settingsState.settings.theme.secondaryColor),
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: Color(settingsState.settings.theme.secondaryColor),
              ),
            ),
            backgroundColor: Color(settingsState.settings.theme.primaryColor),
          ),
          backgroundColor: Color(settingsState.settings.theme.backgroundColor),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, bottom: 8),
                        child: Text(
                          'Customization',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Color(
                            settingsState.settings.theme.secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Builder(
                          builder: (context) {
                            return Column(
                              children: [
                                SettingsToggle<AppBrightness>(
                                  initValue:
                                      settingsState.settings.appBrightness,
                                  segmentsMap: {
                                    AppBrightness.dark: "Dark",
                                    AppBrightness.light: "Light",
                                  },
                                  iconData: Icons.palette_sharp,
                                  settingName: "Theme",
                                  onSelectionChanged: (AppBrightness selected) {
                                    context.read<AppSettingsBloc>().add(
                                      UpdateAppSettings(
                                        settingsState.settings.copyWith(
                                          appBrightness: selected,
                                          theme:
                                              (selected == AppBrightness.dark
                                                      ? AppThemeModel
                                                            .defaultSettingsDark
                                                      : AppThemeModel
                                                            .defaultSettingsLight)
                                                  .toEntity(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SettingsToggle<StartingDay>(
                                  initValue: settingsState.settings.startingDay,
                                  segmentsMap: {
                                    StartingDay.monday: "Monday",
                                    StartingDay.sunday: "Sunday",
                                  },
                                  iconData: Icons.calendar_today_sharp,
                                  settingName: "First day",
                                  onSelectionChanged: (selected) {
                                    var newSettings = settingsState.settings
                                        .copyWith(startingDay: selected);
                                    context.read<AppSettingsBloc>().add(
                                      UpdateAppSettings(newSettings),
                                    );
                                  },
                                ),
                                SettingsToggle<TimeFormat>(
                                  settingName: "Time format",
                                  segmentsMap: {
                                    TimeFormat.h24: "24h",
                                    TimeFormat.h12: "12h",
                                  },
                                  iconData: Icons.av_timer_sharp,
                                  onSelectionChanged: (selected) {
                                    context.read<AppSettingsBloc>().add(
                                      UpdateAppSettings(
                                        settingsState.settings.copyWith(
                                          timeFormat: selected,
                                        ),
                                      ),
                                    );
                                  },
                                  initValue: settingsState.settings.timeFormat,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // SettingsItem(widgetText: "left/right align"),
                // SettingsItem(widgetText: "Reschedule notifications"),
                // SettingsItem(widgetText: "Language?"),
                // SettingsItem(widgetText: "About"),
              ],
            ),
          ),
        );
      },
    );
  }
}
