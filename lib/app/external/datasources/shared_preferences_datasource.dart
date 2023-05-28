import 'dart:convert';

import 'package:epguides_notifier_app/app/data/datasources/database_datasource.dart';
import 'package:epguides_notifier_app/app/data/models/sitcom_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasource implements DatabaseDatasource {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesDatasource(this._sharedPreferences);

  @override
  Future<List<SitcomModel>> getSitcoms() {
    final listKeys = _sharedPreferences.getKeys();

    if (listKeys.isEmpty) return Future<List<SitcomModel>>.value([]);

    final listSitcoms = listKeys.map((key) {
      final sitcomJson = _sharedPreferences.getString(key)!;
      final map = jsonDecode(sitcomJson) as Map<String, dynamic>;
      return SitcomModel.fromMap(map[key]);
    }).toList();

    return Future<List<SitcomModel>>.value(listSitcoms);
  }

  @override
  Future<bool> removeSitcom(SitcomModel sitcom) {
    final result = _sharedPreferences.remove(sitcom.name);
    return result;
  }

  @override
  Future<bool> saveSitcom(SitcomModel sitcom) {
    final result =
        _sharedPreferences.setString(sitcom.name, jsonEncode(sitcom.toMap()));
    return result;
  }
}
