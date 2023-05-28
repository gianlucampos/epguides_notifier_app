import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/app/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/app/external/datasources/epguide_datasource.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final dio = Dio();
  final datasource = EpguideDatasource(dio);

  test('Should check if the episode is available', () async {
    final episodeInfo = EpisodeInfoModel(season: 6, number: 1, title: '', releaseDate: '');
    final result = await datasource.isEpisodeReleased(
        showName: 'youngsheldon', episodeInfo: episodeInfo);
    if (kDebugMode) {
      print(result);
    }

    expect(true, result);
  });

  test('Should return all episodes of a sitcom', () async {
    final result = await datasource.getLastSeasonEpisodes('young sheldon');
    if (kDebugMode) {
      print(result);
    }

    expect(result, isA<List<EpisodeInfoModel>>());
  });
}
