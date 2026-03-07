import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ui/game/components/bubble_icon.dart';
import 'package:ui/game/components/infrastructure_point.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class WorldMap extends World with HasGameReference<SuppressedIntelGame> {
  @override
  FutureOr<void> onLoad() async {
    final darkWorldSprite = await game.images.load('world_map_dark.png');
    // final darkWorldSprite = await game.images.load('world_map_dark_infra.png');
    add(SpriteComponent.fromImage(darkWorldSprite));
    addBubble();

    initializeInfrastructure();

    return super.onLoad();
  }

  void addBubble() {
    add(BubbleIcon(position: Vector2(100, 100)));
  }

  void initializeInfrastructure() {
    for (var location in InfrastructureLocation.values) {
      final temp = Infrastructure(
        location: location,
      );
      add(
        RectangleComponent(
          position: temp.vector2,
          size: Vector2.all(2),
          paint: Paint()..color = Colors.black,
        ),
      );
    }
  }
}
