import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter/material.dart';

class NotiTestClass extends StatefulWidget {
  NotiTestClass({Key? key}) : super(key: key);

  @override
  _NotiTestClassState createState() => _NotiTestClassState();
}

class _NotiTestClassState extends State<NotiTestClass> {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    initializeTimeZones();
    setLocalLocation(getLocation('Europe/Kyiv'));

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

    print("Init doooone");
  }

  Future<void> sentInstantNoti() async {
    final id = 1;
    final title = "Title";
    final body = "idk, body";
    await notificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_noti_id${Random(0).nextInt(100).toString()}',
          'Instant Noti',
          channelDescription: "Instant noti channel",
          importance: Importance.max,
          priority: Priority.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    String? body,
  }) async {
    TZDateTime scheduledDate = TZDateTime.now(local).add(Duration(seconds: 5));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () async {
          print("eh?");
          await sentInstantNoti();
        },
        icon: Icon(Icons.notifications_active_outlined),
      ),
    );
  }
}
