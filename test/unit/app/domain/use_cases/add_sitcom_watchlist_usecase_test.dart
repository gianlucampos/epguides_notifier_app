import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/episode_repository.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/add_sitcom_watchlist_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/episode_info_fixture.dart';
import '../../../../fixtures/sitcom_fixture.dart';

class EpisodeRepositoryMock extends Mock implements EpisodeRepository {}

class SitcomRepositoryMock extends Mock implements SitcomRepository {}

void main() {
  final episodeRepository = EpisodeRepositoryMock();
  final sitcomRepository = SitcomRepositoryMock();
  final EpisodeInfo episodeMock = EpisodeInfoFixture.build;
  final Sitcom sitcomMock = SitcomFixture.build;

  registerFallbackValue(sitcomMock);

  final usecase = AddSitcomWatchListUsecaseImpl(
    episodeRepository: episodeRepository,
    sitcomRepository: sitcomRepository,
  );

  test('Should add a new sitcom with sucess', () async {
    when(() => episodeRepository.getLastSeasonEpisodes('youngsheldon'))
        .thenAnswer((_) async => Right(<EpisodeInfo>[episodeMock]));

    when(() => episodeRepository.isEpisodeReleased(
          showName: 'youngsheldon',
          episodeInfo: episodeMock,
        )).thenAnswer((_) async => const Right(true));

    when(() => sitcomRepository.saveSitcom(any()))
        .thenAnswer((_) async => const Right(true));

    final result = await usecase('youngsheldon');

    expect(result.fold(id, id), true);
  });

  test('Should throw DatasourceError when sitcom doesnt exist on api', () async {
    when(() => episodeRepository.getLastSeasonEpisodes(any()))
        .thenAnswer((_) async => Left(DatasourceError()));

    final result = await usecase('youngsheldon');

    expect(result.fold(id, id), isA<SitcomDoesNotExist>());
  });

  test('Should throw DatabaseError when sitcom is not saved in database', () async {
    when(() => episodeRepository.getLastSeasonEpisodes('youngsheldon'))
        .thenAnswer((_) async => Right(<EpisodeInfo>[episodeMock]));

    when(() => episodeRepository.isEpisodeReleased(
      showName: 'youngsheldon',
      episodeInfo: episodeMock,
    )).thenAnswer((_) async => const Right(true));

    when(() => sitcomRepository.saveSitcom(any()))
        .thenAnswer((_) async => Left(DatasourceError()));

    final result = await usecase('youngsheldon');

    expect(result.fold(id, id), isA<AddSitcomError>());
  });
}
