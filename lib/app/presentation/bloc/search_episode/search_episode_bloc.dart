import 'package:bloc/bloc.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_last_season_episodes.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_event.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchEpisodeBloc extends Bloc<SearchEpisodeEvent, SearchEpisodeState> {
  final GetLastSeasonEpisodes _useCase;

  SearchEpisodeBloc(this._useCase) : super(SearchEpisodeStartState()) {
    on<LoadSearchEpisodeEvent>(_onTextChanged,
        transformer: _onDebounce(const Duration(milliseconds: 800)));
  }

  void _onTextChanged(
      LoadSearchEpisodeEvent event, Emitter<SearchEpisodeState> emit) async {
    final searchText = event.searchText;

    if (searchText.trim().isEmpty) return emit(SearchEpisodeStartState());

    emit(SearchEpisodeLoadingState());

    final result = await _useCase(searchText);
    result.fold(
      (failure) => emit(SearchEpisodeErrorState(failure)),
      (sucess) => emit(SearchEpisodeSucessState(sucess!)),
    );
  }

  EventTransformer<Event> _onDebounce<Event>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
  }
}
