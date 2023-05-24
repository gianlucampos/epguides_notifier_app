import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/save_sitcoms_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/sitcom_fixture.dart';

class SitcomRepositoryMock extends Mock implements SitcomRepository {}

void main() {
  final repository = SitcomRepositoryMock();
  final usecase = SaveSitcomsUsecaseImpl(repository);
  Sitcom sitcomMock = SitcomFixture.build;

  group('SaveSitcomsUsecase', () {
    test('Should persist sitcom in local database', () async {
      when(() => repository.saveSitcom(sitcomMock))
          .thenAnswer((_) async => const Right(true));

      final result = await usecase(sitcomMock);
      expect(result.getOrElse(() => false), true);
    });

    test('Should throw an error if it wont return data', () async {
      when(() => repository.saveSitcom(sitcomMock)).thenThrow(DatasourceError());

      result() async => await usecase(sitcomMock);
      expect(result, throwsA(isA<DatasourceError>()));
    });
  });
}
