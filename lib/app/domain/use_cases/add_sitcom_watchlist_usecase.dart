import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/episode_repository.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';

abstract class AddSitcomWatchListUsecase {
  Future<Either<Failure, bool>> call(String showName);
}

class AddSitcomWatchListUsecaseImpl implements AddSitcomWatchListUsecase {
  final EpisodeRepository episodeRepository;
  final SitcomRepository sitcomRepository;

  AddSitcomWatchListUsecaseImpl({
    required this.episodeRepository,
    required this.sitcomRepository,
  });

  @override
  Future<Either<Failure, bool>> call(String showName) async {
    //TODO create an api call to take a load of before checking last season
    //Check if the sitcom name exists - https://epguides.frecar.no/show/youngsheldon/info/
    //apiDatasource.sitcomExits(showName)
    final listEpisodes =
        await episodeRepository.getLastSeasonEpisodes(showName);
    if (listEpisodes.isLeft()) {
      return Left(SitcomDoesNotExist());
    }
    final lastEpisode = listEpisodes.getOrElse(() => [])!.last;

    final resultIsNewSeasonReleased = await episodeRepository.isEpisodeReleased(
      showName: showName,
      episodeInfo: lastEpisode,
    );
    if (resultIsNewSeasonReleased.isLeft()) {
      return resultIsNewSeasonReleased;
    }
    final isNewSeasonReleased =
        resultIsNewSeasonReleased.getOrElse(() => false);

    final Sitcom sitcom = Sitcom(
      name: showName,
      isReleased: isNewSeasonReleased,
      lastEpisode: lastEpisode,
    );

    final resultIsSaved = await sitcomRepository.saveSitcom(sitcom);
    return resultIsSaved.fold(
      (_) => Left(AddSitcomError(message: 'Not saved in database')),
      (sucess) => Right(sucess),
    );
  }
}
