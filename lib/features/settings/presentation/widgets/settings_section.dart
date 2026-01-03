import 'package:flutter/material.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';

class SettingsSection extends StatelessWidget {
  final String sectionTitle;
  final AppSettingsState settingsState;
  final List<Widget> settingsEntries;
  const SettingsSection({
    super.key,
    required this.sectionTitle,
    required this.settingsState,
    required this.settingsEntries,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 8, left: 6),
          child: Text(
            sectionTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(settingsState.settings.theme.textColor),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Color(settingsState.settings.theme.secondaryColor),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Builder(
            builder: (context) {
              return Column(children: settingsEntries);
            },
          ),
        ),
      ],
    );
  }
}
