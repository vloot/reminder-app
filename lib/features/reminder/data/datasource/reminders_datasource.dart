import 'dart:math';

import 'package:drift/drift.dart';
import 'package:reminders_app/core/infrastructure/database.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';

class RemindersDatasource {
  final Database database;

  RemindersDatasource({required this.database});

  Future<List<ReminderModel>> getReminders() async {
    var rows = await database.select(database.reminderTable).join([
      innerJoin(
        database.reminderWeekdaysTable,
        database.reminderWeekdaysTable.reminderID.equalsExp(
          database.reminderTable.id,
        ),
      ),
    ]).get();

    return formReminders(rows);
  }

  Future<List<ReminderModel>> getDailyReminders(
    List<int> weekdaysIdList,
  ) async {
    return await database.transaction(() async {
      // Find the reminder ids for the chosen day
      final reminderIDs =
          await (database.select(database.reminderWeekdaysTable)
                ..where((tbl) => tbl.weekday.isIn(weekdaysIdList)))
              .map((e) => e.reminderID)
              .get();

      if (reminderIDs.isEmpty) return [];

      // Fetch all weekdays for those reminder ids
      final query = database.select(database.reminderTable).join([
        innerJoin(
          database.reminderWeekdaysTable,
          database.reminderWeekdaysTable.reminderID.equalsExp(
            database.reminderTable.id,
          ),
        ),
      ])..where(database.reminderTable.id.isIn(reminderIDs));

      final rows = await query.get();

      return formReminders(rows);
    });
  }

  Future<ReminderModel> getReminder(int id) async {
    final query = database.select(database.reminderTable)
      ..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingle();
    var reminder = ReminderModel.fromData(row);
    return reminder;
  }

  Future<int> addReminder(ReminderModel reminder) async {
    final id = await database
        .into(database.reminderTable)
        .insert(reminder.toCompanion());

    await database.batch((batch) {
      batch.insertAll(
        database.reminderWeekdaysTable,
        reminder.reminderDays.map((e) {
          return ReminderWeekdaysTableCompanion(
            reminderID: Value(id),
            weekday: Value(e.index),
          );
        }),
      );
    });

    return id;
  }

  Future<int> deleteReminder(int id) async {
    await (database.delete(
      database.reminderWeekdaysTable,
    )..where((t) => t.reminderID.equals(id))).go();

    return await (database.delete(
      database.reminderTable,
    )..where((t) => t.id.equals(id))).go();
  }

  Future<ReminderModel> updateReminder(ReminderModel reminder) async {
    if (reminder.id == null) {
      return reminder;
    }

    await database.transaction(() async {
      await (database.update(database.reminderTable)
            ..where((tbl) => tbl.id.equals(reminder.id ?? -1)))
          .write(reminder.toCompanion());
    });

    await (database.delete(
      database.reminderWeekdaysTable,
    )..where((tbl) => tbl.reminderID.equals(reminder.id ?? -1))).go();

    await database.batch((batch) {
      batch.insertAll(
        database.reminderWeekdaysTable,
        reminder.reminderDays.map((e) {
          return ReminderWeekdaysTableCompanion(
            reminderID: Value(reminder.id ?? -1),
            weekday: Value(e.index),
          );
        }),
      );
    });

    return reminder;
  }

  List<ReminderModel> formReminders(List<TypedResult> rows) {
    final Map<int, ReminderModel> resultsMap = {};

    for (var row in rows) {
      final reminderRow = row.readTable(database.reminderTable);
      final weekdayRow = row.readTableOrNull(database.reminderWeekdaysTable);
      if (!resultsMap.containsKey(reminderRow.id)) {
        resultsMap[reminderRow.id] = ReminderModel.fromData(reminderRow);
      }
      if (weekdayRow == null) {
        continue;
      }

      Weekday weekday;

      switch (weekdayRow.weekday) {
        case 0:
          weekday = Weekday.monday;
        case 1:
          weekday = Weekday.tuesday;
        case 2:
          weekday = Weekday.wednesday;
        case 3:
          weekday = Weekday.thursday;
        case 4:
          weekday = Weekday.friday;
        case 5:
          weekday = Weekday.saturday;
        case 6:
          weekday = Weekday.sunday;
        default:
          weekday = Weekday.monday;
      }

      resultsMap[reminderRow.id]?.reminderDays.add(weekday);
    }

    return resultsMap.values.toList();
  }
}
