import 'package:dio/dio.dart';
import 'package:epguides_notifier_app/app/data/repositories/episode_repository_impl.dart';
import 'package:epguides_notifier_app/app/domain/use_cases/get_last_season_episodes.dart';
import 'package:epguides_notifier_app/app/external/datasources/epguide_datasource.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/pages/episodes_info_page.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => EpguideDatasource(i())),
        Bind((i) => EpisodeRepositoryImpl(i())),
        Bind((i) => GetLastSeasonEpisodesImpl(i())),
        Bind((i) => SearchEpisodeBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const EpisodesInfoPage()),
      ];
}
