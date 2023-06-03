import 'dart:math';

import 'package:epguides_notifier_app/app/data/drivers/notification_driver.dart';
import 'package:epguides_notifier_app/app/domain/entities/notification_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class FlutterNotificationDriver implements NotificationDriver {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<bool> initNotification() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    var isInitialized = await _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    return isInitialized!;
  }

  @override
  Future<void> scheduleNotification(NotificationData notificationData) async {
    final timeZone =
        tz.TZDateTime.from(notificationData.dtScheduled, tz.local);
    final notification = _createNotificationDetails();
    final randomId = Random().nextInt(100);
    //Change by imdbId
    return _notificationsPlugin.zonedSchedule(randomId, notificationData.title, notificationData.body, timeZone, notification,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  NotificationDetails _createNotificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }
}
