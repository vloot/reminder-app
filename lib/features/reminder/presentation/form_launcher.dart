import 'package:flutter/material.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder_form/reminder_form.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';
import 'package:reminders_app/features/settings/presentation/app_settings_state.dart';

Future showReminderForm(
  BuildContext context,
  ReminderFormType formType,
  String titleText,
  AppSettingsState settingsState, {
  required void Function(ReminderModel) submitCallback,
  ReminderModel? reminderModel,
}) async {
  showModalBottomSheet(
    backgroundColor: Color(settingsState.settings.theme.backgroundOverlayColor),
    isScrollControlled: true,
    showDragHandle: true,
    context: context,
    builder: (modalContext) {
      return ReminderForm(
        formType,
        titleText,
        submitCallback,
        settingsState,
        reminderModel: reminderModel,
      );
    },
  );
}
