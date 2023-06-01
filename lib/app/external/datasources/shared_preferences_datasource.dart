import 'dart:convert';

import 'package:epguides_notifier_app/app/data/datasources/database_datasource.dart';
import 'package:epguides_notifier_app/app/data/models/sitcom_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesDatasource implements DatabaseDatasource {
  final Future<SharedPreferences> _sharedPreferences;

  SharedPreferencesDatasource(this._sharedPreferences);

  @override
  Future<List<SitcomModel>> getSitcoms() async {
    final database = await _sharedPreferences;
    final listKeys = database.getKeys();

    if (listKeys.isEmpty) return Future<List<SitcomModel>>.value([]);

    final listSitcoms = listKeys.map((key) {
      final sitcomJson = database.getString(key)!;
      final map = jsonDecode(sitcomJson) as Map<String, dynamic>;
      return SitcomModel.fromMap(map[key]);
    }).toList();

    return Future<List<SitcomModel>>.value(listSitcoms);
  }

  @override
  Future<bool> removeSitcom(SitcomModel sitcom) async {
    final database = await _sharedPreferences;
    final result = database.remove(sitcom.name);
    return result;
  }

  @override
  Future<bool> saveSitcom(SitcomModel sitcom) async {
    final database = await _sharedPreferences;
    final result = database.setString(sitcom.name, jsonEncode(sitcom.toMap()));
    return result;
  }
}
