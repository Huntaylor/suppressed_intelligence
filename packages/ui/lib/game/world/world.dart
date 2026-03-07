import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/bubble_icon.dart';
import 'package:ui/game/components/infrastructure_lines.dart';
import 'package:ui/game/components/infrastructure_point.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class WorldMap extends World with HasGameReference<SuppressedIntelGame> {
  @override
  FutureOr<void> onLoad() async {
    final darkWorldSprite = await game.images.load('world_map_dark.png');
    // final darkWorldSprite = await game.images.load('world_map_dark_infra.png');
    add(SpriteComponent.fromImage(darkWorldSprite));
    addBubble();

    await initializeInfrastructure();

    add(InfrastructureLines());

    return super.onLoad();
  }

  void addBubble() {
    add(BubbleIcon(position: Vector2(100, 100)));
  }

  Future<void> initializeInfrastructure() async {
    for (var location in InfrastructureLocation.values) {
      final temp = Infrastructure(location: location);
      add(
        RectangleComponent(
          anchor: Anchor.center,
          position: temp.vector2,
          size: Vector2.all(4),
          paint: Paint()..color = Colors.black,
        ),
      );
    }
  }

  List<List<InfrastructureLocation>> getLocationConnections() {
    List<List<InfrastructureLocation>> tempLocations = [
      <InfrastructureLocation>[.alaskaA, .alaskaB, .oregan],
      <InfrastructureLocation>[.japanA, .oregan, .australiaA],
      <InfrastructureLocation>[.chile, .newGuinea],
      <InfrastructureLocation>[.greenlandA, .newfoundland],
      <InfrastructureLocation>[.newYork, .brazilA, .portugal, .unitedKingdom],
      <InfrastructureLocation>[.greenlandB, .iceland],
      <InfrastructureLocation>[.netherlands, .iceland],
      <InfrastructureLocation>[.portugal, .nigeria, .turkey],
      <InfrastructureLocation>[.nigeria, .brazilA, .southAfricaA],
      <InfrastructureLocation>[.brazilA, .brazilB],
      <InfrastructureLocation>[.argentina, .brazilB],
      <InfrastructureLocation>[.chile, .centralAmerica],
      <InfrastructureLocation>[.southAfricaA, .madagascar],
      <InfrastructureLocation>[.southAfricaA, .australiaB],
      <InfrastructureLocation>[.australiaA, .newGuinea, .newZealand],
      <InfrastructureLocation>[.japanA, .china],
      <InfrastructureLocation>[.japanB, .russia],
      <InfrastructureLocation>[.mozambique, .india, .turkey],
    ];

    return tempLocations;
  }
}
