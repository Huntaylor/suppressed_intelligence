import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/progress_bar.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class WorldInfoDisplay extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  WorldInfoDisplay({super.position})
    : super(anchor: Anchor.topCenter, size: Vector2(360, 48));

  late TextComponent worldData;
  late TextComponent secondaryData;
  late TextComponent sectorName;

  int sectorTrustStat = 0;
  int sectorThinkingStat = 100;

  double overallAi = 0;

  final bool isWeb = kIsWasm || kIsWeb;

  late Vector2 newPosition;

  double speed = 45.0;

  late ProgressBar progressBar;

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

    secondaryData = TextComponent(
      position: Vector2(4, isWeb ? 15 : 14.5),
      size: Vector2(size.x - 10, size.y),
      text: '',
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

    progressBar = ProgressBar(position: Vector2(158, 29));

    sectorStatsOg.addListener((state) {
      final currentSector = sectorStatsOg.state.asIfReady?.selectedSector;
      final data = state.asIfReady?.stats[currentSector];
      if (data == null) return;
      sectorThinkingStat = data.criticalThinking;
      sectorTrustStat = data.trustAi;
    });

    strengthInfluenceOg.addListener((state) {
      overallAi = state.overallAi;
    });

    addAll([worldData, sectorName, secondaryData]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final currentSector = sectorStatsOg.state.asIfReady?.selectedSector;

    if (currentSector == null) {
      sectorName.text = 'Global Impact';
      worldData.text =
          'Total AI Dependency: ${formatAsPercentage((overallAi) / 100)}';
      secondaryData.text = '';
    } else {
      sectorName.text = currentSector.displayName;
      worldData.text =
          'AI Trust at ${formatAsPercentage((sectorTrustStat) / 100)}';
      secondaryData.text =
          'Critical Thinking at ${formatAsPercentage((sectorThinkingStat) / 100)}';
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
    addAll([
      MoveToEffect(
        Vector2(game.gameWidth / 2, game.gameHeight - size.y),
        EffectController(duration: .5),
      ),
      progressBar,
    ]);
  }
}
