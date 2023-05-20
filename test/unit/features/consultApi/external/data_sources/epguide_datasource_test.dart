import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/features/consultApi/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/errors/errors.dart';
import 'package:epguides_notifier_app/features/consultApi/external/data_sources/epguide_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../fixtures/fixture_reader.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final datasource = EpguideDatasource(dio);

  test('Should check if the episode is available', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
          data: {"status": true},
          statusCode: 200,
          requestOptions: RequestOptions()),
    );

    final result = await datasource.isEpisodeReleased(6, 1);

    expect(true, result);
  });

  test('Should return an DatasourceError if statusCode is not 200', () async {
    when(() => dio.get(any())).thenAnswer(
          (_) async => Response(
          data: null,
          statusCode: 400,
          requestOptions: RequestOptions()),
    );

    final result = datasource.isEpisodeReleased(6, 1);

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

  test('Should return an DatasourceError if statusCode is not 200', () async {
    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
          data: null, statusCode: 400, requestOptions: RequestOptions()),
    );

    final result = datasource.getLastSeasonEpisodes('youngsheldon');

    expect(result, throwsA(isA<DatasourceError>()));
  });

}
