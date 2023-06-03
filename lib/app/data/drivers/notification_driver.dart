import 'package:epguides_notifier_app/app/domain/entities/notification_data.dart';

abstract class NotificationDriver {
  Future<bool> initNotification();

  Future<void> scheduleNotification(NotificationData notificationData);
}
