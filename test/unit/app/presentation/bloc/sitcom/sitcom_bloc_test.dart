import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/add_sitcom_watchlist_usecase.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_sitcoms_usecase.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/remove_sitcoms_usecase.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_event.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/sitcom_fixture.dart';

class AddSitcomWatchListUsecaseMock extends Mock
    implements AddSitcomWatchListUsecase {}

class GetSitcomsUsecaseMock extends Mock implements GetSitcomsUsecase {}

class RemoveSitcomsUsecaseMock extends Mock implements RemoveSitcomsUsecase {}

void main() {
  final addSitcomUsecaseMock = AddSitcomWatchListUsecaseMock();
  final getSitcomsUsecaseMock = GetSitcomsUsecaseMock();
  final removeSitcomUsecaseMock = RemoveSitcomsUsecaseMock();

  final sitcomBloc = SitcomBloc(
    addSitcomWatchListUsecase: addSitcomUsecaseMock,
    getSitcomsUsecase: getSitcomsUsecaseMock,
    removeSitcomsUsecase: removeSitcomUsecaseMock,
  );

  final sitcomMock = SitcomFixture.build;

  test('should emit sucessState when addSitcomEvent', () async* {
    when(() => addSitcomUsecaseMock('youngSheldon'))
        .thenAnswer((_) => Future.value(const Right(true)));
    when(() => getSitcomsUsecaseMock())
        .thenAnswer((_) => Future.value(Right([sitcomMock])));

    expectLater(
      sitcomBloc,
      emitsInOrder([
        LoadingSicomState(),
        StartSicomState(),
        SucessSicomState([sitcomMock])
      ]),
    );

    sitcomBloc.add(AddSitcomEvent('youngSheldon'));
  });

  test('should emit sucessState when removeSitcomEvent', () async* {
    when(() => removeSitcomUsecaseMock(sitcomMock))
        .thenAnswer((_) => Future.value(const Right(true)));
    when(() => getSitcomsUsecaseMock())
        .thenAnswer((_) => Future.value(Right([sitcomMock])));

    expectLater(
      sitcomBloc,
      emitsInOrder([
        LoadingSicomState(),
        StartSicomState(),
        SucessSicomState([sitcomMock])
      ]),
    );

    sitcomBloc.add(RemoveSitcomEvent(sitcomMock));
  });

  test('should emit sucessState when loadSitcomsEvent', () async* {
    when(() => getSitcomsUsecaseMock())
        .thenAnswer((_) => Future.value(Right([sitcomMock])));

    expectLater(
      sitcomBloc,
      emitsInOrder([
        LoadingSicomState(),
        StartSicomState(),
        SucessSicomState([sitcomMock])
      ]),
    );

    sitcomBloc.add(RemoveSitcomEvent(sitcomMock));
  });
}
