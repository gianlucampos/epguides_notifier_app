import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/data/drivers/notification_driver.dart';
import 'package:epguides_notifier_app/app/domain/entities/notification_data.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/services/notification_service.dart';

class NotificationServiceImpl implements NotificationService {
  final NotificationDriver driver;

  NotificationServiceImpl(this.driver);

  @override
  Future<Either<Failure, bool>> initNotification() async {
    final result = await driver.initNotification();
    return result
        ? const Right(true)
        : Left(
            NotificationError(message: 'Failure at initializing notification'));
  }

  @override
  Future<Either<Failure, void>> scheduleNotification(
      NotificationData notificationData) async {
    try {
      return Right(driver.scheduleNotification(notificationData));
    } catch (ex) {
      return Left(NotificationError(message: ex.toString()));
    }
  }
}
