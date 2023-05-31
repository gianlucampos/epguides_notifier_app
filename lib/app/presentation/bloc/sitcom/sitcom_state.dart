import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';

abstract class SitcomState {}

class StartSicomState extends SitcomState {}

class LoadingSicomState extends SitcomState {}

class SucessSicomState extends SitcomState {
  final List<Sitcom> list;

  SucessSicomState(this.list);
}

class ErrorSicomState extends SitcomState {
  final Failure error;

  ErrorSicomState(this.error);
}
