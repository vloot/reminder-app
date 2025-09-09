import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

abstract class ReminderRepository {
  Future<List<ReminderModel>> getReminders();
  Future<ReminderModel> getReminder(int id);
  Future<int> addReminder(
    ReminderModel reminder,
  ); // TODO return type void or some status?
  Future<ReminderModel> removeReminder(int id);
  Future<ReminderModel> editReminder(ReminderModel reminder);
}
