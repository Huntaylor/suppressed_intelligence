import 'package:application/src/objects/game_og.dart';
import 'package:application/src/objects/news_headline_og.dart';
import 'package:application/src/objects/sector_stats_og.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart' as dep_inj;
import 'package:meta/meta.dart';

import 'setup.config.dart';

@internal
late final GetIt getIt;

final providers = {
  GameOg.provider,
  NewsHeadlineOg.provider,
  SectorStatsOg.provider,
};

@dep_inj.setup
void setup(GetIt i) {
  getIt = i..init();
}
