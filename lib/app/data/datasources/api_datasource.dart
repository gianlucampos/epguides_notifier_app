import 'package:epguides_notifier_app/app/data/models/episode_info_model.dart';

abstract class ApiDatasource {

  Future<bool> isEpisodeReleased(int season, int episode);

  Future<List<EpisodeInfoModel>> getLastSeasonEpisodes(String showName);

}
