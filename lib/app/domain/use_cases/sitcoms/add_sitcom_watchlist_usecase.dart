import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:epguides_notifier_app/app/data/models/episode_info_model.dart';
import 'package:epguides_notifier_app/app/domain/entities/notification_data.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:epguides_notifier_app/app/domain/errors/errors.dart';
import 'package:epguides_notifier_app/app/domain/repositories/episode_repository.dart';
import 'package:epguides_notifier_app/app/domain/repositories/sitcom_repository.dart';
import 'package:epguides_notifier_app/app/domain/services/notification_service.dart';

abstract class AddSitcomWatchListUsecase {
  Future<Either<Failure, bool>> call(String showName);
}

class AddSitcomWatchListUsecaseImpl implements AddSitcomWatchListUsecase {
  final EpisodeRepository episodeRepository;
  final SitcomRepository sitcomRepository;
  final NotificationService notificationService;

  AddSitcomWatchListUsecaseImpl({
    required this.episodeRepository,
    required this.sitcomRepository,
    required this.notificationService,
  });

  @override
  Future<Either<Failure, bool>> call(String showName) async {
    //TODO create an api call to take a load of before checking last season
    //Check if the sitcom name exists - https://epguides.frecar.no/show/youngsheldon/info/
    //apiDatasource.sitcomExits(showName)

    //Get ListEpisodes from lastSeason
    final listEpisodes =
        await episodeRepository.getLastSeasonEpisodes(showName);
    if (listEpisodes.isLeft()) {
      return Left(SitcomDoesNotExist());
    }

    //Get lastEpisode from that season
    final lastEpisode = listEpisodes.getOrElse(() => null)!.map((elem) {
      return elem as EpisodeInfoModel;
    }).reduce((value, element) {
      return value.number >= element.number ? value : element;
    });

    //Check if is released
    final resultIsNewSeasonReleased = await episodeRepository.isEpisodeReleased(
      showName: showName,
      episodeInfo: lastEpisode,
    );
    if (resultIsNewSeasonReleased.isLeft()) {
      return resultIsNewSeasonReleased;
    }
    final isNewSeasonReleased =
        resultIsNewSeasonReleased.getOrElse(() => false);

    //Persist episode on local database
    final Sitcom sitcom = Sitcom(
      name: showName,
      isReleased: isNewSeasonReleased,
      lastEpisode: lastEpisode,
    );

    final resultIsSaved = await sitcomRepository.saveSitcom(sitcom);
    //Schedule a notification when new season is released
    if (resultIsSaved.isRight()) {
      final dtRelease = DateTime.now().add(const Duration(seconds: 5));
      // final dtRelease = DateTime.parse(lastEpisode.releaseDate);
      NotificationData data = NotificationData(
          dtScheduled: dtRelease,
          title:
              '${sitcom.lastEpisode.season}º season of ${sitcom.name} is now available!');
      final notificationResult = notificationService.scheduleNotification(data);
      notificationResult.then((value) => value.fold(
            (failure) => log((failure as NotificationError).message),
            (sucess) => log('Notification was sent with sucess!'),
          ));
    }

    return resultIsSaved.fold(
      (_) => Left(AddSitcomError(message: 'Not saved in database')),
      (sucess) => Right(sucess),
    );
  }
}
