import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/world/world.dart';

class SuppressedIntelGame extends FlameGame
    with TapCallbacks, MouseMovementDetector {
  SuppressedIntelGame();

  Color blueBackground = Color.fromARGB(255, 91, 110, 225);
  Color darkBlueBackground = Color.fromARGB(255, 35, 35, 58);

  late bool debugVector;

  late WorldMap worldMap;

  late TextComponent mouseDebug;
  late TextComponent positionText;

  late String mouseText;

  late Vector2 mousePosition;

  @override
  FutureOr<void> onLoad() async {
    debugVector = false;

    mousePosition = Vector2.zero();
    mouseText = 'Initial Text';
    mouseDebug = TextComponent(text: mouseText, priority: 2);

    await images.loadAllImages();

    _cameraSetup();
    if (debugVector) {
      world.add(mouseDebug);
    }
    return super.onLoad();
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    if (debugVector) {
      final localPosition = camera.globalToLocal(info.eventPosition.global);
      mousePosition = localPosition;
      mouseText = Vector2(
        mousePosition.x.ceilToDouble(),
        mousePosition.y.ceilToDouble(),
      ).toString();
    }

    super.onMouseMove(info);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (debugVector) {
      positionText = TextComponent(
        anchor: Anchor.bottomCenter,
        textRenderer: TextPaint(
          style: TextPaint.defaultTextStyle.copyWith(
            backgroundColor: Colors.black,
            color: Colors.red,
            fontSize: 8,
          ),
        ),
        text: mouseText,
        priority: 2,
        position: camera.globalToLocal(event.localPosition),
      );
      world.add(positionText);
    }
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    if (debugVector) {
      mouseDebug
        ..position = mousePosition
        ..text = mouseText;
    }

    super.update(dt);
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
