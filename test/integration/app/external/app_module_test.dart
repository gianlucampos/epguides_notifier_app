import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/app/app_module.dart';
import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_last_season_episodes.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:modular_test/modular_test.dart';

import '../../../fixtures/fixture_reader.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  initModule(AppModule(), replaceBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Should recover usecase without error', () {
    final usecase = Modular.get<GetLastSeasonEpisodes>();
    expect(usecase, isA<GetLastSeasonEpisodesImpl>());
  });

  test('Should bring a list of last episodes', () async {
    final dataMock = jsonDecode(fixture('getLastSeasonEpisodes.json'));

    when(() => dio.get(any())).thenAnswer(
      (_) async => Response(
          data: dataMock, statusCode: 200, requestOptions: RequestOptions()),
    );

    final usecase = Modular.get<GetLastSeasonEpisodes>();
    final result = await usecase('young sheldon');

    expect(result | null, isA<List<EpisodeInfo>>());
  });
}
