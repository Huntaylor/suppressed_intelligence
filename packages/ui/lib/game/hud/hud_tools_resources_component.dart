import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/hud/hud_pause_button.dart';
import 'package:ui/game/hud/hud_upgrade_button.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class HudToolsResourcesComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  HudToolsResourcesComponent({
    super.position,
    required this.hudPauseButton,
    required this.hudUpgradeButton,
  }) : super(anchor: .topLeft, size: Vector2(134, 70));

  final HudUpgradeButton hudUpgradeButton;
  final HudPauseButton hudPauseButton;

  late TextComponent moneyDisplay;
  late TextComponent title;

  final bool isWeb = kIsWasm || kIsWeb;

  @override
  FutureOr<void> onLoad() async {
    final nineTileImage = await game.images.load(
      'windows_95_no_close_chatgpt_thin.png',
    );

    title = TextComponent(
      position: Vector2(3, isWeb ? 2 : -.25),
      text: 'Tools and Resources',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );

    hudUpgradeButton.position = Vector2(5, 14.5);
    hudPauseButton.position = Vector2(99, 14.5);

    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 1,
      bottomHeight: 2,
      leftWidth: 9,
      rightWidth: 9,
    );

    moneyDisplay = TextComponent(
      position: Vector2(5, 43),
      size: Vector2(size.x - 10, size.y),
      text: '\$\$\$\$',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );

    addAll([hudPauseButton, hudUpgradeButton, moneyDisplay, title]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final moneyAmount = moneyOg.state.amount;

    moneyDisplay.text = '\$$moneyAmount';
    super.update(dt);
  }

  void moveHud() {
    add(
      MoveToEffect(
        Vector2(position.x - (size.x * 2) - 16, position.y),
        EffectController(duration: .5),
      ),
    );
  }
}
