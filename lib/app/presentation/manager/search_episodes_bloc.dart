import 'package:bloc/bloc.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_last_season_episodes.dart';
import 'package:epguides_notifier_app/app/presentation/manager/search_episodes_state.dart';
import 'package:rxdart/transformers.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final GetLastSeasonEpisodes useCase;

  SearchBloc(this.useCase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String event) async* {
    yield SearchLoading();
    final result = await useCase(event);
    yield result.fold((l) => SearchError(l), (r) => SearchSucess(r!));
  }

  @override
  Stream<Transition<String, SearchState>> transformEvents(Stream<String> events,
      TransitionFunction<String, SearchState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(milliseconds: 800)), transitionFn);
  }
}
