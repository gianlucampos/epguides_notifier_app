import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';

abstract class SearchEpisodeState {}

class SearchEpisodeStartState implements SearchEpisodeState {}

class SearchEpisodeLoadingState implements SearchEpisodeState {}

class SearchEpisodeSucessState implements SearchEpisodeState {
  final List<EpisodeInfo> list;

  SearchEpisodeSucessState(this.list);
}

class SearchEpisodeErrorState implements SearchEpisodeState {
  final Failure error;

  SearchEpisodeErrorState(this.error);
}