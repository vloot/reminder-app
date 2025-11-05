import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

abstract class NotificationRepository {
  void sendInstantNotification();
  Future<void> scheduleNotification(ReminderModel reminder);
  Future<void> cancelNotification(ReminderModel reminder);
}
