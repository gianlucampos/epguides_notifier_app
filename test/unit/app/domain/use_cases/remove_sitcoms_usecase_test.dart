import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/sitcoms/remove_sitcoms_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/sitcom_fixture.dart';
import 'get_sitcoms_usecase_test.dart';

void main() {
  final repository = SitcomRepositoryMock();
  final usecase = RemoveSitcomsUsecaseImpl(repository);
  Sitcom sitcomMock = SitcomFixture.build;

  group('RemoveSitcomsUsecase', () {
    test('Should remove sitcom in local database', () async {
      when(() => repository.removeSitcom(sitcomMock))
          .thenAnswer((_) async => const Right(true));

      final result = await usecase(sitcomMock);
      expect(result.getOrElse(() => false), true);
    });

    test('Should throw an error if it wont return data', () async {
      when(() => repository.removeSitcom(sitcomMock)).thenThrow(DatasourceError());

      result() async => await usecase(sitcomMock);
      expect(result, throwsA(isA<DatasourceError>()));
    });
  });
}
