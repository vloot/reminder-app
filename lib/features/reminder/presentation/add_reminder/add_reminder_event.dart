import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class AddReminderEvent {}

class SubmitReminderEvent extends AddReminderEvent {
  final String title;
  final String description;
  final DateTime time;
  final Set<Weekday> reminderDays;

  SubmitReminderEvent({
    required this.title,
    required this.description,
    required this.time,
    required this.reminderDays,
  });
}
