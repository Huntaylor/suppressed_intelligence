import 'package:application/src/objects/game_config_og.dart';
import 'package:application/src/objects/game_og.dart';
import 'package:application/src/objects/money_og.dart';
import 'package:application/src/objects/game_time_og.dart';
import 'package:application/src/objects/news_headline_og.dart';
import 'package:application/src/objects/sector_bubble_og.dart';
import 'package:application/src/objects/sector_stats_og.dart';
import 'package:application/src/objects/strength_influence_og.dart';
import 'package:application/src/objects/upgrades_og.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart' as dep_inj;
import 'package:meta/meta.dart';

import 'setup.config.dart';

@internal
late final GetIt getIt;

final providers = {
  GameOg.provider,
  GameTimeOg.provider,
  MoneyOg.provider,
  NewsHeadlineOg.provider,
  SectorBubbleOg.provider,
  SectorStatsOg.provider,
  GameConfigOg.provider,
  StrengthInfluenceOg.provider,
  UpgradesOg.provider,
};

@dep_inj.setup
void setup(GetIt i) {
  getIt = i..init();
}
