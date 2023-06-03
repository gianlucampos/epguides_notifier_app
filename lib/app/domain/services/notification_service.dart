import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/notification_data.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';

abstract class NotificationService {
  Future<Either<Failure, bool>> initNotification();

  Future<Either<Failure, void>> scheduleNotification(
      NotificationData notificationData);
}
