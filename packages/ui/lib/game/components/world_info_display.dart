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

  final bool isWeb = kIsWasm || kIsWeb;

  late Vector2 newPosition;

  double speed = 45.0;

  late ProgressBar mainProgressBar;
  late ProgressBar secondaryProgressBar;

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
        style: const TextStyle(fontSize: 11, color: Colors.white),
      ),
    );

    secondaryData = TextComponent(
      position: Vector2(4, isWeb ? 15 : 14.5),
      size: Vector2(size.x - 10, size.y),
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 11, color: Colors.white),
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

    mainProgressBar = ProgressBar(position: Vector2(158, 29));
    secondaryProgressBar = ProgressBar(position: Vector2(158, 15));

    sectorStatsOg.addListener((state) {
      final currentSector = state.asIfReady?.selectedSector;
      final data = state.asIfReady?.stats[currentSector];
      if (data == null) return;
      sectorThinkingStat = data.criticalThinking;
      sectorTrustStat = data.trustAi;
    });

    addAll([worldData, sectorName, secondaryData]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final currentSector = sectorStatsOg.state.asIfReady?.selectedSector;

    if (currentSector == null) {
      final overallAiStat = strengthInfluenceOg.state.overallAi;
      final oiStat = strengthInfluenceOg.state.oi;
      secondaryProgressBar.setProgress = oiStat;
      mainProgressBar.setProgress = overallAiStat.toInt();
      sectorName.text = 'Global Impact';
      worldData.text =
          'Global AI Dependency at ${formatAsPercentage((overallAiStat))}';
      secondaryData.text = 'OI Influence at ${formatAsPercentage((oiStat))}';

      if (gameConfigOg.state.isOIPresent) {
        if (secondaryProgressBar.opacity != 1) {
          secondaryProgressBar.opacity = 1;
        }
        secondaryData.text = 'OI Influence at ${formatAsPercentage((oiStat))}';
      } else {
        secondaryData.text = '';
        if (secondaryProgressBar.opacity != 0) {
          secondaryProgressBar.opacity = 0;
        }
      }
    } else {
      // Trust AI Progress
      mainProgressBar.setProgress = sectorTrustStat;

      // Critical Thinking Progress
      secondaryProgressBar.setProgress = sectorThinkingStat;

      if (secondaryProgressBar.opacity != 1) {
        secondaryProgressBar.opacity = 1;
      }

      sectorName.text = currentSector.displayName;
      worldData.text = 'AI Trust at ${formatAsPercentage((sectorTrustStat))}';
      secondaryData.text =
          'Critical Thinking at ${formatAsPercentage((sectorThinkingStat))}';
    }

    super.update(dt);
  }

  String formatAsPercentage(num value) {
    return '${value.floor()}%';
  }

  void displayInfo() {
    addAll([
      MoveToEffect(
        Vector2(game.gameWidth / 2, game.gameHeight - size.y),
        EffectController(duration: .5),
      ),
      mainProgressBar,
      secondaryProgressBar,
    ]);
  }
}
