import 'package:epguides_notifier_app/app/data/models/episode_info_model.dart';

abstract class ApiDatasource {
  Future<bool> isEpisodeReleased({
    required String showName,
    required EpisodeInfoModel episodeInfo,
  });

  Future<List<EpisodeInfoModel>> getLastSeasonEpisodes(String showName);
}
