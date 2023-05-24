import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';

class Sitcom {
  final String name;
  final bool isReleased;
  final EpisodeInfo lastEpisode;

  const Sitcom({
    required this.name,
    required this.isReleased,
    required this.lastEpisode,
  });
}