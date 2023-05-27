import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';

class SitcomModel extends Sitcom {
  const SitcomModel({
    name,
    isReleased,
    lastEpisode,
  }) : super(
          name: name,
          isReleased: isReleased,
          lastEpisode: lastEpisode,
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sitcom &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          isReleased == other.isReleased &&
          lastEpisode == other.lastEpisode);

  @override
  int get hashCode =>
      name.hashCode ^ isReleased.hashCode ^ lastEpisode.hashCode;

  @override
  String toString() {
    return 'SitcomModel{ name: $name, isReleased: $isReleased, lastEpisode: $lastEpisode}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isReleased': isReleased,
      'lastEpisode': lastEpisode,
    };
  }

  factory SitcomModel.fromMap(Map<String, dynamic> map) {
    return SitcomModel(
      name: map['name'] as String,
      isReleased: map['isReleased'] as bool,
      lastEpisode: map['lastEpisode'] as EpisodeInfo,
    );
  }
}
