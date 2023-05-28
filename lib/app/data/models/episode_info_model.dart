import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';

class EpisodeInfoModel extends EpisodeInfo {
  EpisodeInfoModel({
    number,
    season,
    title,
    releaseDate,
  }) : super(
          number: number,
          season: season,
          title: title,
          releaseDate: releaseDate,
        );

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'season': season,
      'title': title,
      'releaseDate': releaseDate,
    };
  }

  factory EpisodeInfoModel.fromMap(Map<String, dynamic> map) {
    return EpisodeInfoModel(
      number: map['number'] as int,
      season: map['season'] as int,
      title: map['title'] as String,
      releaseDate: map['release_date']  ?? map['releaseDate']  as String,
    );
  }

  @override
  String toString() {
    return 'EpisodeInfoModel{number: $number, season: $season, title: $title, releaseDate: $releaseDate}';
  }

  factory EpisodeInfoModel.downcast(EpisodeInfo episodeInfo) {
    return EpisodeInfoModel(
      number: episodeInfo.number,
      releaseDate: episodeInfo.releaseDate,
      season: episodeInfo.season,
      title: episodeInfo.title
    );
  }
}
