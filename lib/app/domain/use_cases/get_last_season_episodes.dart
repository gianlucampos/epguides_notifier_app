import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/episode_repository.dart';

abstract class GetLastSeasonEpisodes {
  Future<Either<Failure, List<EpisodeInfo>?>> call(String showName);
}

class GetLastSeasonEpisodesImpl implements GetLastSeasonEpisodes {
  final EpisodeRepository repository;

  GetLastSeasonEpisodesImpl(this.repository);

  @override
  Future<Either<Failure, List<EpisodeInfo>?>> call(String showName) async {
    if (showName.isEmpty) return Left(InvalidTextError());

    return repository.getLastSeasonEpisodes(showName);
  }
}
