import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/app_themes.dart';

class Confirmation extends StatelessWidget {
  final Future<void> Function() onConfirmCallback;
  final Future<void> Function() onCancelCallback;

  const Confirmation(
    this.onConfirmCallback,
    this.onCancelCallback, {
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
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () async {
                    await onConfirmCallback();
                    Navigator.pop(context, true);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      currentTheme.warningColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentTheme.secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    onCancelCallback();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      currentTheme.inactiveColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: currentTheme.secondaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
