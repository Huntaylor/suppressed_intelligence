import 'dart:async';

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
  }) : super(anchor: .topLeft, size: Vector2(134, 45));

  final HudUpgradeButton hudUpgradeButton;
  final HudPauseButton hudPauseButton;

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

    hudUpgradeButton.position = Vector2(5, 14);
    hudPauseButton.position = Vector2(99, 14);

    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 8,
      bottomHeight: 2,
      leftWidth: 9,
      rightWidth: 9,
    );

    addAll([hudPauseButton, hudUpgradeButton, title]);
    return super.onLoad();
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
