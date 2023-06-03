import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/sitcoms/get_sitcoms_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/sitcom_fixture.dart';

class SitcomRepositoryMock extends Mock implements SitcomRepository {}

void main() {
  final repository = SitcomRepositoryMock();
  final usecase = GetSitcomsUsecaseImpl(repository);
  Sitcom sitcomMock = SitcomFixture.build;

  group('GetSitcomsUsecase', () {
    test('Should return a list of sitcoms persisted in local database',
        () async {
      when(() => repository.getSitcoms())
          .thenAnswer((_) async => Right(<Sitcom>[sitcomMock]));

      final result = await usecase();
      expect(result.getOrElse(() => []), isA<List<Sitcom>>());
      expect(result.getOrElse(() => [])[0].name, sitcomMock.name);
      expect(result.getOrElse(() => [])[0].isReleased, sitcomMock.isReleased);
      expect(result.getOrElse(() => [])[0].lastEpisode, sitcomMock.lastEpisode);
    });

    test('Should throw an error if it wont return data', () async {
      when(() => repository.getSitcoms()).thenThrow(DatasourceError());

      result() async => await usecase();
      expect(result, throwsA(isA<DatasourceError>()));
    });
  });
}
