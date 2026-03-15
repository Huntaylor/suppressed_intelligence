import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/tutorial_button.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class TutorialInfoWindowComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  TutorialInfoWindowComponent({super.position})
    : super(anchor: .center, size: Vector2(250, 100));

  late TextComponent title;
  late TextComponent subTitle;
  late TutorialButton tutorialButton;

  final bool isWeb = kIsWasm || kIsWeb;

  @override
  FutureOr<void> onLoad() async {
    priority = game.infoWindowPriority;

    final nineTileImage = await game.images.load(
      'windows_95_no_close_chatgpt_thin.png',
    );

    title = TextComponent(
      position: Vector2(3, isWeb ? 5 : 2),
      text: 'Tutorial',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
    subTitle = TextComponent(
      position: Vector2(3, 22),
      size: size,
      text: tutorialOg.state.tutorialStrings[tutorialOg.state.tutorialStep],
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
    tutorialButton = TutorialButton(
      position: Vector2(size.x / 1.05, size.y / 1.3),
      onPressed: () {
        tutorialOg.events.next();
        removeFromParent();
      },
    );

    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 1,
      bottomHeight: 2,
      leftWidth: 9,
      rightWidth: 9,
    );

    addAll([title, subTitle, tutorialButton]);
    return super.onLoad();
  }
}
