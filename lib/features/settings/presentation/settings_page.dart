import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/core/shared/common.dart';
import 'package:reminders_app/core/shared/time_format.dart';
import 'package:reminders_app/core/shared/weekday_info.dart';
import 'package:reminders_app/features/app_info/app_info.dart';
import 'package:reminders_app/features/app_info/app_info_service.dart';
import 'package:reminders_app/features/settings/data/models/app_theme_model.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_bloc.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_event.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/features/settings/presentation/widgets/settings_section.dart';
import 'package:reminders_app/features/settings/presentation/widgets/settings_toggle.dart';
import 'package:reminders_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppInfoService appInfoService = AppInfoService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      bloc: context.read<AppSettingsBloc>(),
      builder: (context, settingsState) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(settingsState.settings.theme.secondaryColor),
            ),
            title: Text(
              l10n.settingsTitle,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: Color(settingsState.settings.theme.secondaryColor),
              ),
            ),
            backgroundColor: Color(settingsState.settings.theme.primaryColor),
          ),
          backgroundColor: Color(settingsState.settings.theme.backgroundColor),
          body: ListView(
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
                    SettingsSection(
                      sectionTitle: l10n.settingsCustomization,
                      settingsState: settingsState,
                      settingsEntries: [
                        SettingsToggle<AppBrightness>(
                          initValue: settingsState.settings.appBrightness,
                          segmentsMap: {
                            AppBrightness.dark: l10n.themeDark,
                            AppBrightness.light: l10n.themeLight,
                          },
                          iconData: Icons.palette_sharp,
                          settingName: l10n.settingsTheme,
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
                        Builder(
                          builder: (context) {
                            var mon = l10n.monday;
                            var sun = l10n.sunday;
                            if (mon.length > 6 || sun.length > 6) {
                              mon = l10n.mondayAbbr.toUpperCase();
                              sun = l10n.sundayAbbr.toUpperCase();
                            }

                            return SettingsToggle<StartingDay>(
                              initValue: settingsState.settings.startingDay,
                              segmentsMap: {
                                StartingDay.monday: mon,
                                StartingDay.sunday: sun,
                              },
                              iconData: Icons.calendar_today_sharp,
                              settingName: l10n.settingsFirstDay,
                              onSelectionChanged: (selected) {
                                var newSettings = settingsState.settings
                                    .copyWith(startingDay: selected);
                                context.read<AppSettingsBloc>().add(
                                  UpdateAppSettings(newSettings),
                                );
                              },
                            );
                          },
                        ),
                        SettingsToggle<TimeFormat>(
                          settingName: l10n.settingsTimeFormat,
                          segmentsMap: {
                            TimeFormat.h24: "24",
                            TimeFormat.h12: "12",
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
                        ListTile(
                          leading: Icon(Icons.translate_sharp),
                          title: Text(l10n.settingsLang),
                          trailing: DropdownButton(
                            value: settingsState.settings.locale,
                            items: [
                              DropdownMenuItem(
                                value: Locale('en'),
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: Locale('uk'),
                                child: Text('Українська'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                context.read<AppSettingsBloc>().add(
                                  LocaleChanged(value),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SettingsSection(
                      sectionTitle: l10n.settingsAbout,
                      settingsState: settingsState,
                      settingsEntries: [
                        ListTile(
                          leading: Icon(Icons.code),
                          title: Text(l10n.settingsSourceCode),
                          trailing: ElevatedButton(
                            onPressed: () async {
                              try {
                                await launchUrl(Uri.parse(repoLink));
                              } catch (e) {
                                // TODO handdle error
                              }
                            },
                            child: Text(l10n.settingsOpenRepo),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.numbers_sharp),
                          title: Text(l10n.settingsAppVersion),
                          trailing: FutureBuilder<AppInfo>(
                            future: appInfoService.load(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return SizedBox.shrink();
                              return Text(
                                snapshot.data!.version,
                                style: TextStyle(fontSize: 14),
                              );
                            },
                          ),
                        ),
                      ],
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
        );
      },
    );
  }
}
