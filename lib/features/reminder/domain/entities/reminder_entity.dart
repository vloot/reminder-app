import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class ReminderEntity {
  final int id;
  final String title;
  final String description;
  final DateTime time;
  final Set<Weekday> reminderDays;

  ReminderEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.reminderDays,
  });
}
