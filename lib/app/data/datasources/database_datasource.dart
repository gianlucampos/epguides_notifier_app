import 'package:epguides_notifier_app/app/data/models/sitcom_model.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';

abstract class DatabaseDatasource {
  Future<List<SitcomModel>> getSitcoms();

  Future<bool> saveSitcom(Sitcom sitcom);

  Future<bool> removeSitcom(Sitcom sitcom);

}