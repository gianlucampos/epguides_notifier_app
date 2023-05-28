import 'package:epguides_notifier_app/app/data/models/sitcom_model.dart';

abstract class DatabaseDatasource {
  Future<List<SitcomModel>> getSitcoms();

  Future<bool> saveSitcom(SitcomModel sitcom);

  Future<bool> removeSitcom(SitcomModel sitcom);

}