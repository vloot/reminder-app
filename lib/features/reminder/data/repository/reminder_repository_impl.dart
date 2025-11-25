import 'package:reminders_app/features/reminder/data/datasource/reminders_datasource.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/entities/reminder_entity.dart';
import 'package:reminders_app/features/reminder/domain/entities/weekdays_enum.dart';
import 'package:reminders_app/features/reminder/domain/repository/reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final RemindersDatasource datasource;

  ReminderRepositoryImpl({required this.datasource});

  @override
  Future<int> addReminder(ReminderEntity entity) async {
    final reminder = ReminderModel(
      title: entity.title,
      description: entity.description,
      time: entity.time,
      reminderDays: entity.reminderDays,
    );
    return await datasource.addReminder(reminder);
  }

  @override
  Future<ReminderModel> editReminder(ReminderEntity reminder) async {
    return await datasource.updateReminder(ReminderModel.fromEntity(reminder));
  }

  @override
  Future<ReminderModel> getReminder(int id) async {
    return await datasource.getReminder(id);
  }

  @override
  Future<List<ReminderModel>> getReminders() async {
    return await datasource.getReminders();
  }

  @override
  Future<int> deleteReminder(ReminderModel reminder) async {
    return await datasource.deleteReminder(reminder.id!);
  }

  @override
  Future<List<ReminderModel>> getDailyReminders(Set<Weekday> weekdaysSet) {
    return datasource.getDailyReminders(
      weekdaysSet.map((e) => e.index).toList(),
    );
  }
}
