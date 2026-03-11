import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/bubble_icon.dart';
import 'package:ui/game/components/data_bubble.dart';
import 'package:ui/game/components/infrastructure_lines.dart';
import 'package:ui/game/components/infrastructure_point.dart';
import 'package:ui/game/components/sector_component.dart';
import 'package:ui/game/components/sector_placement_component.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class WorldMap extends World with HasGameReference<SuppressedIntelGame> {
  late Timer timer;

  late List<Path> dataPaths;

  @override
  FutureOr<void> onLoad() async {
    dataPaths = getLocationPaths();

    timer = Timer(.25, onTick: addMovement, repeat: true);
    final darkWorldSprite = await game.images.load('world_map_dark.png');
    // final darkWorldSprite = await game.images.load('world_map_dark_infra.png');
    add(SpriteComponent.fromImage(darkWorldSprite));
    addBubble();

    await initializeInfrastructure();

    add(InfrastructureLines());
    // if (!game.debugGame) {
    await addSectors();
    // }
    // if (game.debugGame) {
    //   await addDragSector();
    // }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    timer.update(dt);
    super.update(dt);
  }

  void addMovement() {
    final dataBubble = DataBubble(
      dataPaths: dataPaths,
      radius: 3,
      anchor: Anchor.center,
    );
    add(dataBubble);
  }

  void addBubble() {
    add(BubbleIcon(position: Vector2(100, 100)));
  }

  Future<void> initializeInfrastructure() async {
    for (var location in InfrastructureLocation.values) {
      add(
        CircleComponent(
          priority: 2,
          anchor: Anchor.center,
          position: location.vector2,
          radius: 2,
          paint: Paint()..color = Colors.white,
        ),
      );
    }
  }

  List<Path> getLocationPaths() {
    List<Path> paths = [];
    final vectorPaths = InfrastructureLines().vector2Connections();

    for (var vectorPath in vectorPaths) {
      final tempPath = Path();

      final p = _createPath(vectorPath, tempPath);

      paths.add(p);
    }

    for (var reversePath in vectorPaths) {
      final tempPath = Path();

      final p = _createPath(reversePath.reversed.toList(), tempPath);

      paths.add(p);
    }

    return paths;
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

Path _createPath(List<Vector2> vectors, Path path) {
  path.moveTo(vectors.first.x, vectors.first.y);

  for (var i = 0; i < vectors.length - 1; i++) {
    path.quadraticBezierTo(
      vectors[i].x,
      vectors[i].y,
      (vectors[i].x + vectors[i + 1].x) / 2,
      (vectors[i].y + vectors[i + 1].y) / 2,
    );
  }

  path.lineTo(vectors.last.x, vectors.last.y);

  return path;
}
