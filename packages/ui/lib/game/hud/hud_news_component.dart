import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/hud/marquee_text_component.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class HudNewsComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  HudNewsComponent({super.position, super.size})
    : super(anchor: Anchor.topCenter);

  late TextComponent aiName;

  @override
  FutureOr<void> onLoad() async {
    aiName = TextComponent(
      position: Vector2(2, -.5),
      text: gameConfigOg.state.name,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
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

    final newsText = MarqueeTextComponent(
      position: Vector2(4, 11),
      size: Vector2(size.x - 8, size.y),
      text:
          'Breaking news, this text will continue to show what we call *breaking news*, why you ask? Because we said so, that\'s why. Now get the heck out of here before I pump your guts full of led!',
    );
    addAll([newsText, aiName]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (aiName.text != gameConfigOg.state.name) {
      aiName.text = gameConfigOg.state.name;
    }
  }
}
