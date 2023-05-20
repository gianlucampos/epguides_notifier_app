import 'package:epguides_notifier_app/features/consultApi/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/errors/errors.dart';

abstract class SearchState {}

class SearchSucess implements SearchState {
  final List<EpisodeInfo> list;

  SearchSucess(this.list);
}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);
}
