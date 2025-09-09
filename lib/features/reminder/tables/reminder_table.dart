import 'package:drift/drift.dart';

class ReminderTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 32)();
  TextColumn get description => text().withLength(min: 0, max: 128)();
  DateTimeColumn get time => dateTime().nullable()();
}
