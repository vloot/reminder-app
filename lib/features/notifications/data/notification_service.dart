import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Location? location;

  NotificationService() {
    init();
  }

  Future<void> init() async {
    initializeTimeZones();
    // final localTimeZone = await FlutterTimezone.getLocalTimezone();
    final localTimeZone = 'Europe/Kyiv';
    location = getLocation(localTimeZone);
    setLocalLocation(location!);

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await notificationsPlugin.initialize(initializationSettings);

    // Android 13+ permission
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required DateTime time,
    String? body,
  }) async {
    TZDateTime scheduledDate = TZDateTime.from(time, location!);
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminders_channel_id',
          'Reminders',
          channelDescription: "Reminders to do tasks",
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  void sendInstantNotification({
    required int id,
    required String title,
    String? body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'reminders_channel_id',
          'Reminders',
          channelDescription: "Reminders to do tasks",
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
