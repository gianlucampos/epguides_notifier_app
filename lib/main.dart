import 'package:epguides_notifier_app/app/app_module.dart';
import 'package:epguides_notifier_app/app/app_widget.dart';
import 'package:epguides_notifier_app/app/external/drivers/flutter_notification_driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  //http://worldtimeapi.org/api/ip
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  final driver = FlutterNotificationDriver();
  driver.initNotification();

  runApp(
    ModularApp(
      module: AppModule(driver: driver),
      child: const AppWidget(),
    ),
  );
}
