import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/entities/reminder_entity.dart';

abstract class ReminderRepository {
  Future<List<ReminderModel>> getReminders();
  Future<ReminderModel> getReminder(int id);
  Future<int> addReminder(ReminderEntity reminder);
  Future<int> deleteReminder(ReminderModel reminder);
  Future<ReminderModel> editReminder(ReminderEntity reminder);
}
