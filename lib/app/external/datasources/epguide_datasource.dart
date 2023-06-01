import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/app/data/datasources/api_datasource.dart';
import 'package:epguides_notifier_app/app/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';

class EpguideDatasource implements ApiDatasource {
  static const String episodeReleased =
      "https://epguides.frecar.no/show/{showName}/{season}/{episode}/released/";
  static const String showInfo = "https://epguides.frecar.no/show/{showName}/";

  final Dio dio;

  EpguideDatasource(this.dio);

  @override
  Future<bool> isEpisodeReleased({
    required String showName,
    required EpisodeInfoModel episodeInfo,
  }) async {
    String url = episodeReleased
        .replaceAll('{showName}', showName)
        .replaceAll('{season}', episodeInfo.season.toString())
        .replaceAll('{episode}', episodeInfo.number.toString());
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data['status'];
    } else {
      throw DatasourceError();
    }
  }

  @override
  Future<List<EpisodeInfoModel>> getLastSeasonEpisodes(String showName) async {
    String url = showInfo.replaceAll('{showName}', showName);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final lastSeason = response.data.keys.last;
        return (response.data[lastSeason] as List)
            .map((e) => EpisodeInfoModel.fromMap(e))
            .toList();
      } else {
        throw DatasourceError();
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
