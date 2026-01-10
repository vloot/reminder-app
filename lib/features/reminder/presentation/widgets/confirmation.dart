import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';
import 'package:reminders_app/l10n/app_localizations.dart';

class Confirmation extends StatelessWidget {
  final Future<void> Function() onConfirmCallback;
  final Future<void> Function() onCancelCallback;
  final AppSettingsState settingsState;

  const Confirmation({
    required this.onConfirmCallback,
    required this.onCancelCallback,
    super.key,
    required this.settingsState,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      height: MediaQuery.of(context).copyWith().size.height * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            l10n.deleteTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildButton(
                l10n.delete,
                Color(settingsState.settings.theme.secondaryColor),
                Color(settingsState.settings.theme.warningColor),
                onConfirmCallback,
              ),
              buildButton(
                l10n.cancel,
                Color(settingsState.settings.theme.secondaryColor),
                Color(settingsState.settings.theme.inactiveColor),
                onCancelCallback,
              ),
            ],
          ),
          SizedBox(),
        ],
      ),
    );
  }

  SizedBox buildButton(
    String text,
    Color textColor,
    Color backgroundColor,
    Future<void> Function() callback,
  ) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () async {
          await callback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: Size(135, 45),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
