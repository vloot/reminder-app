import 'package:reminders_app/features/notifications/data/notification_service.dart';
import 'package:reminders_app/features/notifications/domain/notification_repository.dart';
import 'package:reminders_app/features/reminder/data/model/reminder_model.dart';
import 'package:reminders_app/features/reminder/domain/reminder_extensions.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  NotificationService notificationService;

  NotificationRepositoryImpl({required this.notificationService});

  @override
  void cancelNotification(ReminderModel reminder) {
    notificationService.cancelNotification(reminder.id!);
  }

  @override
  Future<void> scheduleNotification(ReminderModel reminder) async {
    final notiDates = reminder.getReminderDates();
    for (var date in notiDates) {
      await notificationService.scheduleNotification(
        id: _calculateID(reminder.id!, date.weekday - 1),
        title: reminder.title,
        body: reminder.description,
        time: date,
      );
    }
  }

  @override
  void sendInstantNotification() {
    notificationService.sendInstantNotification(
      id: 0,
      title: "Instant notification",
      body: "You should instantly see this notification",
    );
  }

  int _calculateID(int id, int weekdayID) {
    return id * 10 + weekdayID + 1;
  }
}
