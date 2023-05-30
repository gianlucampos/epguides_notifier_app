import 'package:epguides_notifier_app/app/domain/entities/sitcom.dart';
import 'package:random_string/random_string.dart';

import 'episode_info_fixture.dart';

abstract class SitcomFixture {
  static get build => Sitcom(
      name: randomString(25),
      isReleased: int.parse(randomNumeric(1)).isEven,
      lastEpisode: EpisodeInfoFixture.build);
}
