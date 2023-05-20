import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/features/consultApi/data/data_sources/api_datasource.dart';
import 'package:epguides_notifier_app/features/consultApi/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/features/consultApi/data/repositories/episode_repository_impl.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class ApiDatasourceMock extends Mock implements ApiDatasource {}

void main() {
  final datasource = ApiDatasourceMock();
  final repository = EpisodeRepositoryImpl(datasource);

  test('should return a list of episodes', () async {
    when(() => datasource.getLastSeasonEpisodes(any()))
        .thenAnswer((_) async => <EpisodeInfoModel>[]);

    final result = await repository.getLastSeasonEpisodes('youngsheldon');
    expect(result | null, isA<List<EpisodeInfo>>());
  });

  test('should return an DataSourceError if datasource fails', () async {
    when(() => datasource.getLastSeasonEpisodes(any()))
        .thenThrow(Exception());

    final result = await repository.getLastSeasonEpisodes('youngsheldon');
    expect(result.fold(id,id), isA<DatasourceError>());
  });
}
