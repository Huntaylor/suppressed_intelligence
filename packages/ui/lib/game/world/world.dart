import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ui/game/components/bubble_icon.dart';
import 'package:ui/game/components/infrastructure_point.dart';
import 'package:ui/game/suppressed_intel_game.dart';

enum WorldSectors {
  na('53-4E41'),
  sa('53-5341'),
  eu('53-4555'),
  as('53-4153'),
  af('53-4146'),
  oc('53-4F43')
  ;

  const WorldSectors(this.codeName);
  final String codeName;
}

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
