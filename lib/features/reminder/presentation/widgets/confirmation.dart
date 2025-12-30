import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      height: MediaQuery.of(context).copyWith().size.height * 0.22,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Delete reminder?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildButton(
                'Delete',
                Color(settingsState.settings.secondaryColor),
                Color(settingsState.settings.warningColor),
                onConfirmCallback,
              ),
              buildButton(
                'Cancel',
                Color(settingsState.settings.secondaryColor),
                Color(settingsState.settings.inactiveColor),
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
