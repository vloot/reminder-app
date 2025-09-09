import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';

abstract class NotificationRepository {
  void sendInstantNotification();
  Future<void> scheduleNotification(ReminderModel reminder);
  void cancelNotification(ReminderModel reminder);
}
