import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminders_app/features/settings/data/models/app_settings_model.dart';
import 'package:reminders_app/features/settings/domain/entities/app_settings_entity.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_bloc.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_event.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';

class SettingsPage extends StatefulWidget {
  final AppSettingsState settingsState;
  const SettingsPage(this.settingsState, {super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Set<AppBrightness> _selection = <AppBrightness>{AppBrightness.system};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(widget.settingsState.settings.secondaryColor),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 28,
            color: Color(widget.settingsState.settings.secondaryColor),
          ),
        ),
        backgroundColor: Color(widget.settingsState.settings.primaryColor),
      ),
      backgroundColor: Color(widget.settingsState.settings.backgroundColor),
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
                  Text('Customization'),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(
                        widget.settingsState.settings.secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Builder(
                      builder: (context) {
                        return ListTile(
                          leading: Icon(Icons.color_lens_sharp),
                          title: Text('Theme'),
                          trailing: SegmentedButton<AppBrightness>(
                            multiSelectionEnabled: false,
                            emptySelectionAllowed: false,
                            showSelectedIcon: false,
                            segments: [
                              // ButtonSegment(
                              //   value: AppBrightness.system,
                              //   label: Text('System'),
                              // ),
                              ButtonSegment(
                                value: AppBrightness.light,
                                label: Text('Light'),
                              ),
                              ButtonSegment(
                                value: AppBrightness.dark,
                                label: Text('Dark'),
                              ),
                            ],
                            selected: _selection,
                            onSelectionChanged:
                                (Set<AppBrightness> newSelection) {
                                  _selection = newSelection;
                                  AppSettingsEntity newSettings;

                                  final selected = _selection.first;

                                  if (selected == AppBrightness.light) {
                                    newSettings = AppSettingsModel
                                        .defaultSettingsLight
                                        .toEntity();
                                  } else if (selected == AppBrightness.dark) {
                                    newSettings = AppSettingsModel
                                        .defaultSettingsDark
                                        .toEntity();
                                  } else {
                                    Brightness systemBrightness = MediaQuery.of(
                                      context,
                                    ).platformBrightness;

                                    newSettings =
                                        (systemBrightness == Brightness.light
                                                ? AppSettingsModel
                                                      .defaultSettingsLight
                                                      .toEntity()
                                                : AppSettingsModel
                                                      .defaultSettingsDark
                                                      .toEntity())
                                            .copyWith(
                                              appBrightness:
                                                  AppBrightness.system,
                                            );
                                  }

                                  context.read<AppSettingsBloc>().add(
                                    UpdateAppSettings(newSettings),
                                  );
                                },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // SettingsItem(widgetText: "Theme/mode"),
            // SettingsItem(widgetText: "left/right align"),
            // SettingsItem(widgetText: "24h/12h (sun/mon)"),
            // SettingsItem(widgetText: "noti sound"),
            // SettingsItem(widgetText: "Reschedule notifications"),
            // SettingsItem(widgetText: "Language?"),
            // SettingsItem(widgetText: "About"),
          ],
        ),
      ),
    );
  }
}
