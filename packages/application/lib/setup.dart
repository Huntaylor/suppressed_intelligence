import 'package:application/src/objects/game_object.dart';
import 'package:scoped_deps/scoped_deps.dart';

void setupDeps(void Function() runner) {
  runScoped(runner, values: {gameObjectProvider});
}
