import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/app/data/repositories/episode_repository_impl.dart';
import 'package:epguides_notifier_app/app/data/repositories/sitcom_repository_impl.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_last_season_episodes.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/sitcoms/add_sitcom_watchlist_usecase.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/sitcoms/get_sitcoms_usecase.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/sitcoms/remove_sitcoms_usecase.dart';
import 'package:epguides_notifier_app/app/external/datasources/epguide_datasource.dart';
import 'package:epguides_notifier_app/app/external/datasources/shared_preferences_datasource.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/pages/episodes_info_page.dart';
import 'package:epguides_notifier_app/app/presentation/pages/sitcom_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => EpguideDatasource(i())),
        Bind((i) => EpisodeRepositoryImpl(i())),
        Bind((i) => GetLastSeasonEpisodesImpl(i())),
        Bind((i) => SearchEpisodeBloc(i())),
        Bind((i) => SharedPreferences.getInstance()),
        Bind((i) => SharedPreferencesDatasource(i())),
        Bind((i) => SitcomRepositoryImpl(i())),
        Bind((i) => GetSitcomsUsecaseImpl(i())),
        Bind((i) => RemoveSitcomsUsecaseImpl(i())),
        Bind((i) => AddSitcomWatchListUsecaseImpl(
              episodeRepository: EpisodeRepositoryImpl(i()),
              sitcomRepository: SitcomRepositoryImpl(i()),
            )),
        Bind((i) => SitcomBloc(
            getSitcomsUsecase: i(),
            addSitcomWatchListUsecase: i(),
            removeSitcomsUsecase: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SitcomPage()),
        ChildRoute('/episodes', child: (context, args) => EpisodesInfoPage()),
      ];
}
