import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class ReminderEvent {}

class AddReminderEvent extends ReminderEvent {
  final String title;
  final String description;
  final DateTime time;
  final Set<Weekday> reminderDays;

  AddReminderEvent({
    required this.title,
    required this.description,
    required this.time,
    required this.reminderDays,
  });
}

class EditReminderEvent extends ReminderEvent {
  final int id;
  final String title;
  final String description;
  final DateTime time;
  final Set<Weekday> reminderDays;

  EditReminderEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.reminderDays,
  });
}

class DeleteReminderEvent extends ReminderEvent {
  final ReminderModel reminder;

  DeleteReminderEvent({required this.reminder});
}
