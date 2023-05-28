import 'package:epguides_notifier_app/app/data/datasources/api_datasource.dart';
import 'package:epguides_notifier_app/app/data/datasources/database_datasource.dart';
import 'package:epguides_notifier_app/app/data/models/sitcom_model.dart';
import 'package:epguides_notifier_app/app/domain/services/sitcom_service.dart';

class SitcomServiceImpl implements SitcomService {
  final ApiDatasource apiDatasource;
  final DatabaseDatasource databaseDatasource;

  const SitcomServiceImpl({
    required this.apiDatasource,
    required this.databaseDatasource,
  });

  @override
  Future<bool> addSitcomWatchList(String showName) async {
    //TODO create an api call to take a load of before checking last season
    //Check if the sitcom name exists - https://epguides.frecar.no/show/youngsheldon/info/
    //apiDatasource.sitcomExits(showName)
    final listEpisodes = await apiDatasource.getLastSeasonEpisodes(showName);
    final lastEpisode = listEpisodes.last;
    final isNewSeasonReleased = await apiDatasource.isEpisodeReleased(
      showName: showName,
      episodeInfo: lastEpisode,
    );

    final sitcom = SitcomModel(
      name: showName,
      isReleased: isNewSeasonReleased,
      lastEpisode: lastEpisode,
    );
    return await databaseDatasource.saveSitcom(sitcom);
  }
}
