import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSucess implements SearchState {
  final List<EpisodeInfo> list;

  SearchSucess(this.list);
}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchError implements SearchState {
  final Failure error;

  SearchError(this.error);
}
