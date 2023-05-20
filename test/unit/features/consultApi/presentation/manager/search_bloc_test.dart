import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/use_cases/get_last_season_episodes.dart';
import 'package:epguides_notifier_app/features/consultApi/presentation/manager/search_bloc.dart';
import 'package:epguides_notifier_app/features/consultApi/presentation/manager/states/search_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetLastSeasonEpisodesMock extends Mock implements GetLastSeasonEpisodes {}

void main() {
  final useCase = GetLastSeasonEpisodesMock();
  final bloc = SearchBloc(useCase);

  test("Should return states in the correct order", () async* {
    when(() => useCase.call(any()))
        .thenAnswer((_) async => const Right(<EpisodeInfo>[]));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSucess>(),
        ]));

    bloc.add("young sheldon");
  });
}
