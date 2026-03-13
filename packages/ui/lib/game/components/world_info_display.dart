import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class WorldInfoDisplay extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  WorldInfoDisplay({super.position})
    : super(anchor: Anchor.topCenter, size: Vector2(360, 48));

  late TextComponent worldData;
  late TextComponent sectorName;

  final bool isWeb = kIsWasm || kIsWeb;

  late Vector2 newPosition;

  late WorldSectors? currentSector;

  double speed = 45.0;

  @override
  FutureOr<void> onLoad() async {
    sectorName = TextComponent(
      position: Vector2(3, isWeb ? 3 : .5),
      text: 'World',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );

    worldData = TextComponent(
      position: Vector2(4, isWeb ? 30 : 29),
      size: Vector2(size.x - 10, size.y),
      text: 'World Data',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );

    newPosition = position;
    final nineTileImage = await game.images.load(
      'windows_95_no_close_chatgpt.png',
    );

    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 9,
      bottomHeight: 2,
      leftWidth: 9,
      rightWidth: 9,
    );

    addAll([worldData, sectorName]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    currentSector = sectorStatsOg.state.asIfReady?.selectedSector;

    if (currentSector == null) {
      sectorName.text = 'Global Impact';
      worldData.text =
          'Total AI Dependency: ${formatAsPercentage((strengthInfluenceOg.state.overallAi / 6) / 100)}';
    } else {
      sectorName.text = currentSector!.displayName;
      worldData.text =
          'Sector AI Dependency: ${formatAsPercentage((strengthInfluenceOg.state.ai[currentSector] ?? 0) / 100)}';
    }
    super.update(dt);
  }

  String formatAsPercentage(num value, {int decimalPlaces = 0}) {
    final percentage = value * 100;
    String formatted = percentage.toStringAsFixed(decimalPlaces);

    if (decimalPlaces > 0) {
      formatted = formatted.replaceAll(RegExp(r'\.?0+$'), '');
    }

    return '$formatted%';
  }

  void displayInfo() {
    add(
      MoveToEffect(
        Vector2(game.gameWidth / 2, game.gameHeight - size.y),
        EffectController(duration: .5),
      ),
    );
  }
}
