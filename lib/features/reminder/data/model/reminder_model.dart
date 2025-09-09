import 'package:drift/drift.dart';
import 'package:reminders_app/core/infrastructure/database.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class ReminderModel {
  final int? id;
  final String title;
  final String? description;
  final DateTime time;
  final Set<Weekday> reminderDays;

  ReminderModel({
    this.id,
    required this.title,
    this.description,
    required this.time,
    required this.reminderDays,
  });

  ReminderTableCompanion toCompanion() {
    return ReminderTableCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      title: Value(title),
      description: Value(description ?? ""),
      time: Value(time),
    );
  }

  factory ReminderModel.fromData(ReminderTableData tableData) {
    return ReminderModel(
      id: tableData.id,
      title: tableData.title,
      description: tableData.description,
      time: tableData.time ?? DateTime.now(),
      reminderDays: <Weekday>{},
    );
  }

  ReminderModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? time,
    Set<Weekday>? reminderDays,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      reminderDays: reminderDays ?? this.reminderDays,
    );
  }
}
