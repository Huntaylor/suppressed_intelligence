import 'dart:async';

import 'package:flame/components.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class WorldMap extends World with HasGameReference<SuppressedIntelGame> {
  @override
  FutureOr<void> onLoad() async {
    final worldSprite = await game.images.load('world_map_outline.png');
    final darkWorldSprite = await game.images.load('world_map_dark.png');
    add(SpriteComponent.fromImage(darkWorldSprite));
    return super.onLoad();
  }
}
