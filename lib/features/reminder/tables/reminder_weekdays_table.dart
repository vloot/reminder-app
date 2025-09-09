import 'package:drift/drift.dart';
import 'package:reminders_app/features/reminder/tables/reminder_table.dart';

class ReminderWeekdaysTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reminderID => integer().references(ReminderTable, #id)();
  IntColumn get weekday => integer()();
}
