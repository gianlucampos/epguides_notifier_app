import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/app/external/datasources/epguide_datasource.dart';
import 'package:epguides_notifier_app/app/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/episode_info_fixture.dart';
import '../../../../fixtures/fixture_reader.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final datasource = EpguideDatasource(dio);
  final episodeInfoMock = EpisodeInfoModel.downcast(EpisodeInfoFixture.build);

  test('Should check if the episode is available', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
          data: {"status": true},
          statusCode: 200,
          requestOptions: RequestOptions()),
    );

    final result = await datasource.isEpisodeReleased(
        showName: 'young sheldon',
        episodeInfo: episodeInfoMock);

    expect(true, result);
  });

  test('Should return an DatasourceError if isEpisodeReleased statusCode is not 200', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
          data: null, statusCode: 400, requestOptions: RequestOptions()),
    );

    final result = datasource.isEpisodeReleased(
        showName: 'youngsheldon', episodeInfo: episodeInfoMock);

    expect(result, throwsA(isA<DatasourceError>()));
  });

  test('Should return all episodes of a sitcom', () async {
    final dataMock = jsonDecode(fixture('getLastSeasonEpisodes.json'));

    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
          data: dataMock, statusCode: 200, requestOptions: RequestOptions()),
    );

    final result = await datasource.getLastSeasonEpisodes('youngsheldon');

    expect(result, isA<List<EpisodeInfoModel>>());
  });

  test('Should return an DatasourceError if getLastSeasonEpisodes statusCode is not 200', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
          data: null, statusCode: 400, requestOptions: RequestOptions()),
    );

    final result = datasource.getLastSeasonEpisodes('youngsheldon');

    expect(result, throwsA(isA<DatasourceError>()));
  });
}
