import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminders_app/features/reminder/tables/reminder_table.dart';
import 'package:reminders_app/features/reminder/tables/reminder_weekdays_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [ReminderTable, ReminderWeekdaysTable])
class Database extends _$Database {
  Database([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'reminders_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
