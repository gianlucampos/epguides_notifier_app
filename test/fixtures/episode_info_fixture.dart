import 'package:epguides_notifier_app/app/domain/entities/episode_info.dart';
import 'package:random_string/random_string.dart';

class EpisodeInfoFixture {
  static get build => EpisodeInfo(
      number: int.parse(randomNumeric(1)),
      season: int.parse(randomNumeric(1)),
      title: randomString(25),
      releaseDate: DateTime.now().toString());
}
