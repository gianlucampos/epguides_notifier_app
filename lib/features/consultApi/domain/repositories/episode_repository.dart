import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/features/consultApi/domain/errors/errors.dart';

abstract class EpisodeRepository {
  Future<Either<FailureSearch, List<EpisodeInfo>?>> getLastSeasonEpisodes(String showName);
}
