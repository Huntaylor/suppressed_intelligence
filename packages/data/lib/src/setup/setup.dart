import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart' as dep_inj;

import 'setup.config.dart';

@dep_inj.setup
void setup(GetIt i) {
  final seed = DateTime.now().millisecondsSinceEpoch;
  i.registerSingleton(Random(seed));
  i.init();
}
