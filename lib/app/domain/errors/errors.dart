abstract class Failure implements Exception {}

class InvalidTextError implements Failure {}

class DatasourceError implements Failure {
  final String? message;

  DatasourceError({this.message});
}

class AddSitcomError implements Failure {
  final String message;

  AddSitcomError({required this.message});
}

class SitcomDoesNotExist implements Failure {
  final message = 'Sitcom does not exist';
}

class NotificationError implements Failure {
  final String message;

  NotificationError({required this.message});
}