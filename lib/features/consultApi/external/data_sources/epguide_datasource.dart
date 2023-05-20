import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/features/consultApi/data/data_sources/api_datasource.dart';
import 'package:epguides_notifier_app/features/consultApi/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/errors/errors.dart';

class EpguideDatasource implements ApiDatasource {
  static const String episodeReleased =
      "https://epguides.frecar.no/show/youngsheldon/{season}/{episode}/released/";
  static const String showInfo = "https://epguides.frecar.no/show/{showInfo}/";

  final Dio dio;

  EpguideDatasource(this.dio);

  @override
  Future<bool> isEpisodeReleased(int season, int episode) async {
    String url = episodeReleased
        .replaceAll('{season}', season.toString())
        .replaceAll('{episode}', episode.toString());
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data['status'];
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<List<EpisodeInfoModel>> getLastSeasonEpisodes(String showName) async {
    String url = showInfo.replaceAll('{showInfo}', showName);
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final lastSeason = response.data.keys.last;
      return (response.data[lastSeason] as List)
          .map((e) => EpisodeInfoModel.fromMap(e))
          .toList();
    } else {
      throw DatasourceError();
    }
  }
}
