import 'dart:async';
import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:ui/game/world/world.dart';

class SuppressedIntelGame extends FlameGame
    with TapCallbacks, MouseMovementDetector {
  SuppressedIntelGame();

  Color blueBackground = Color.fromARGB(255, 91, 110, 225);
  Color darkBlueBackground = Color.fromARGB(255, 35, 35, 58);

  late WorldMap worldMap;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    _cameraSetup();
    return super.onLoad();
  }

  @override
  Color backgroundColor() => darkBlueBackground;

  void _cameraSetup() {
    worldMap = WorldMap();

    world = worldMap;

    final viewfinder = Viewfinder()..anchor = Anchor.topLeft;
    camera = CameraComponent.withFixedResolution(
      width: 1024,
      height: 515,
      world: world,
      viewfinder: viewfinder,
    );
  }
}
