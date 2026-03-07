import 'package:application/src/objects/game_og.dart';
import 'package:application/src/objects/news_headline_og.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart' as dep_inj;
import 'package:meta/meta.dart';
import 'package:scoped_deps/scoped_deps.dart';

import 'setup.config.dart';

@internal
late final GetIt getIt;

@dep_inj.setup
void setupDeps(GetIt i, void Function() runner) {
  getIt = i..init();
  runScoped(runner, values: {GameOg.provider, NewsHeadlineOg.provider});
}
