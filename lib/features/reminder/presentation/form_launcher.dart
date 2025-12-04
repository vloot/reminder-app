import 'package:flutter/material.dart';
import 'package:reminders_app/core/themes/app_themes.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder_form/reminder_form.dart';
import 'package:reminders_app/features/reminder_form/reminder_form_type.dart';

Future showReminderForm(
  BuildContext context,
  ReminderFormType formType,
  String titleText, {
  required void Function(ReminderModel) submitCallback,
  ReminderModel? reminderModel,
}) async {
  showModalBottomSheet(
    backgroundColor: currentTheme.backgroundOverlayColor,
    isScrollControlled: true,
    showDragHandle: true,
    context: context,
    builder: (modalContext) {
      return ReminderForm(
        formType,
        titleText,
        context,
        submitCallback,
        reminderModel: reminderModel,
      );
    },
  );
}
