import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';

abstract class SitcomEvent {}

class AddSitcomEvent extends SitcomEvent {
  final String sitcomName;

  AddSitcomEvent(this.sitcomName);
}

class RemoveSitcomEvent extends SitcomEvent {
  final Sitcom sitcom;

  RemoveSitcomEvent(this.sitcom);
}

class LoadSitcomsEvent extends SitcomEvent {}
