import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/episode_repository.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_last_season_episodes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class EpisodeRepositoryMock extends Mock implements EpisodeRepository {}

main() {
  final repository = EpisodeRepositoryMock();
  final usecase = GetLastSeasonEpisodesImpl(repository);

  test('Should return a list of episodes from last season', () async {
    when(() => repository.getLastSeasonEpisodes(any()))
        .thenAnswer((_) async => const Right(<EpisodeInfo>[]));

    final result = await usecase('youngSheldon');
    expect(result | null, isA<List<EpisodeInfo>>());
  });

  test('Should return a InvalidTextError if text is Invalid', () async {
    when(() => repository.getLastSeasonEpisodes(any()))
        .thenAnswer((_) async => const Right(<EpisodeInfo>[]));

    final result = await usecase('');
    expect(result.fold(id,id), isA<InvalidTextError>());
  });
}
