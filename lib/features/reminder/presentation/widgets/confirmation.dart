import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/app_themes.dart';

class Confirmation extends StatelessWidget {
  final Future<void> Function() onConfirmCallback;
  final Future<void> Function() onCancelCallback;

  const Confirmation({
    required this.onConfirmCallback,
    required this.onCancelCallback,
    super.key,
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
                context,
                'Delete',
                currentTheme.secondaryColor,
                currentTheme.warningColor,
                onConfirmCallback,
              ),
              buildButton(
                context,
                'Cancel',
                currentTheme.secondaryColor,
                currentTheme.inactiveColor,
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
    BuildContext context,
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
