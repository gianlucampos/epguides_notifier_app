import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/data/datasources/database_datasource.dart';
import 'package:epguides_notifier_app/app/data/models/sitcom_model.dart';
import 'package:epguides_notifier_app/app/data/repositories/sitcom_repository_impl.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/sitcom_fixture.dart';

class DatabaseDatasourceMock extends Mock implements DatabaseDatasource {}

void main() {
  final datasource = DatabaseDatasourceMock();
  final repository = SitcomRepositoryImpl(datasource);
  final Sitcom sitcomMock = SitcomFixture.build;
  final SitcomModel sitcomModelMock = SitcomModel.downcast(sitcomMock);

  test('should return a list of sitcoms', () async {
    when(() => datasource.getSitcoms())
        .thenAnswer((_) async => <SitcomModel>[sitcomModelMock]);

    final result = await repository.getSitcoms();
    expect(result.fold(id, id), isA<List<SitcomModel>>());
  });

  test('should return a empty list of sitcoms', () async {
    when(() => datasource.getSitcoms())
        .thenAnswer((_) async => <SitcomModel>[]);

    final result = await repository.getSitcoms();
    expect(result.fold(id, id), isA<List<SitcomModel>>());
  });

  test('should save a sitcom', () async {
    when(() => datasource.saveSitcom(sitcomModelMock)).thenAnswer((_) async => true);

    final result = await repository.saveSitcom(sitcomMock);
    expect(result.fold(id, id), true);
  });

  test('should remove a sitcom', () async {
    when(() => datasource.removeSitcom(sitcomModelMock))
        .thenAnswer((_) async => true);

    final result = await repository.removeSitcom(sitcomMock);
    expect(result.fold(id, id), true);
  });

  test('should return an DataSourceError if getSitcoms fails', () async {
    when(() => datasource.getSitcoms()).thenThrow(Exception());

    final result = await repository.getSitcoms();
    expect(result.fold(id, id), isA<DatasourceError>());
  });

  test('should return an DataSourceError if saveSitcom fails', () async {
    when(() => datasource.saveSitcom(sitcomModelMock)).thenThrow(Exception());

    final result = await repository.saveSitcom(sitcomMock);
    expect(result.fold(id, id), isA<DatasourceError>());
  });

  test('should return an DataSourceError if removeSitcom fails', () async {
    when(() => datasource.removeSitcom(sitcomModelMock)).thenThrow(Exception());

    final result = await repository.removeSitcom(sitcomMock);
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
