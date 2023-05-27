import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_last_season_episodes.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_event.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetLastSeasonEpisodesMock extends Mock implements GetLastSeasonEpisodes {}

void main() {
  final useCase = GetLastSeasonEpisodesMock();
  final bloc = SearchEpisodeBloc(useCase);

  test("Should return states in the correct order", () async* {
    when(() => useCase.call(any()))
        .thenAnswer((_) async => const Right(<EpisodeInfo>[]));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchEpisodeLoadingState>(),
          isA<SearchEpisodeSucessState>(),
        ]));

    bloc.add(LoadSearchEpisodeEvent(searchText: "young sheldon"));
  });
}
