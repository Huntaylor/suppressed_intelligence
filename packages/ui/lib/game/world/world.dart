import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:ui/game/components/info_dots_component.dart';
import 'package:ui/game/components/pipes_component.dart';
import 'package:ui/game/components/sector_bubbles_component.dart';
import 'package:ui/game/components/sector_component.dart';
import 'package:ui/game/components/sector_names_debug_component.dart';
import 'package:ui/game/components/sector_placement_component.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class WorldMap extends World with HasGameReference<SuppressedIntelGame> {
  WorldMap();

  @override
  FutureOr<void> onLoad() async {
    final darkWorldSprite = await game.images.load('world_map_dark.png');
    // final darkWorldSprite = await game.images.load('world_map_dark_infra.png');

    addAll([
      SpriteComponent.fromImage(darkWorldSprite),
      SectorBubblesComponent(),
      PipesComponent(),
      InfoDotsComponent(),
    ]);
    // if (!game.debugGame) {
    await addSectors();
    // }
    // if (game.debugGame) {
    //   await addDragSector();
    // }
    if (game.debugGame) {
      add(SectorNamesDebugComponent());
    }

    return super.onLoad();
  }

  // Used to debug the sector positions
  Future<void> addDragSector() async {
    final image = await game.images.load('sector_sprites/sector_6.png');
    final sector = SectorPlacementComponent(
      position: Vector2(705.5, 219.0),
      size: Vector2(401.0, 304.0),
      sprite: Sprite(image),
    );

    add(sector);
  }

  Future<void> addSectors() async {
    for (var sector in WorldSectors.values) {
      add(SectorComponent(sector: sector));
    }
  }
}
