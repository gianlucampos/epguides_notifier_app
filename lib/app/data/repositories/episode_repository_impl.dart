import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/data/datasources/api_datasource.dart';
import 'package:epguides_notifier_app/app/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/episode_repository.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  final ApiDatasource datasource;

  EpisodeRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, bool>> isEpisodeReleased(
      {required String showName, required EpisodeInfo episodeInfo}) async {
    try {
      final result = await datasource.isEpisodeReleased(
        showName: showName,
        episodeInfo: EpisodeInfoModel.downcast(episodeInfo),
      );
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }

  @override
  Future<Either<Failure, List<EpisodeInfo>?>> getLastSeasonEpisodes(
      String showName) async {
    try {
      final result = await datasource.getLastSeasonEpisodes(showName);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
