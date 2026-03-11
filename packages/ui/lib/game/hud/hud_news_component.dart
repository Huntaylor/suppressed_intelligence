import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/hud/marquee_text_component.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class HudNewsComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  HudNewsComponent({super.position, super.size})
    : super(anchor: Anchor.topCenter);

  late TextComponent aiName;
  late MarqueeTextComponent newsText;

  final bool isWeb = kIsWasm || kIsWeb;

  @override
  FutureOr<void> onLoad() async {
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
    return super.onLoad();
  }

  Future<void> startNews() async {
    opacity = 1;
    newsHeadlineOg.events.init();

    aiName = TextComponent(
      position: Vector2(2, -.5),
      text: gameConfigOg.state.name,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );

    newsText = MarqueeTextComponent(
      position: Vector2(4, 11),
      size: Vector2(size.x - 8, size.y),
      text: '',
    );

    addAll([newsText, aiName]);
  }

  @override
  void update(double dt) {
    if (opacity != 0) {
      if (aiName.text != gameConfigOg.state.name) {
        aiName.text = gameConfigOg.state.name;
      }

      if (newsHeadlineOg.state.asIfReady?.data.headline
          case final String headline) {
        if (newsText.text != headline) {
          newsText.text = headline;
        }
      }
    }
  }
}
