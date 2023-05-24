abstract class Failure implements Exception {}

class InvalidTextError implements Failure {}

class DatasourceError implements Failure {
  final String? message;

  DatasourceError({this.message});
}
