import 'dart:convert';

import 'package:epguides_notifier_app/app/data/models/sitcom_model.dart';
import 'package:epguides_notifier_app/app/external/datasources/shared_preferences_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/sitcom_fixture.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  final sharedPreferences = Future.value(SharedPreferencesMock());
  final datasource = SharedPreferencesDatasource(sharedPreferences);
  final SitcomModel sitcomModelMock = SitcomModel.downcast(SitcomFixture.build);

  group('shared_preferences_datasource_test', () {
    test('should get sitcoms list from sharedPreferences database', () async {
      final database = await sharedPreferences;

      when(() => database.getKeys())
          .thenAnswer((_) => <String>{sitcomModelMock.name});

      var details = jsonEncode({sitcomModelMock.name: sitcomModelMock.toMap()});

      when(() => database.getString(any()))
          .thenAnswer((_) => details);

      final result = await datasource.getSitcoms();

      expect(result, isA<List<SitcomModel>>());
    });

    test('should get sitcoms empty list from sharedPreferences database',
        () async {
          final database = await sharedPreferences;

          when(() => database.getKeys()).thenAnswer((_) => <String>{});

      final result = await datasource.getSitcoms();

      expect(result, isA<List<SitcomModel>>());
    });

    test('should save from sitcom from sharedPreferences database', () async {
      final database = await sharedPreferences;

      when(() => database.setString(any(), any()))
          .thenAnswer((_) async => true);

      final result = await datasource.saveSitcom(sitcomModelMock);

      expect(result, true);
    });

    test('should remove from sitcom from sharedPreferences database', () async {
      final database = await sharedPreferences;

      when(() => database.remove(any())).thenAnswer((_) async => true);

      final result = await datasource.removeSitcom(sitcomModelMock);

      expect(result, true);
    });
  });
}
