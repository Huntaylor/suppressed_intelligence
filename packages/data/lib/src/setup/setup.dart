import 'package:get_it/get_it.dart';
import 'package:get_it_injector/get_it_injector.dart' as dep_inj;

import 'setup.config.dart';

@dep_inj.setup
void setup(GetIt i) {
  i.init();
}
