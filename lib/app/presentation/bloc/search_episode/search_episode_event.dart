abstract class SearchEpisodeEvent {}

class LoadSearchEpisodeEvent implements SearchEpisodeEvent {
  String searchText;

  LoadSearchEpisodeEvent({
    required this.searchText,
  });
}
