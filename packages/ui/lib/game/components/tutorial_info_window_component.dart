import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/tutorial_button.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class TutorialInfoWindowComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  TutorialInfoWindowComponent({super.position})
    : super(anchor: .center, size: Vector2(250, 125));

  late TextComponent title;
  late TextComponent tutorialCountText;
  late TextComponent subTitle;
  late TutorialButton tutorialButton;

  late MoveToEffect moveToEffect;

  double moveEffectDuration = .25;

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
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
    tutorialCountText = TextComponent(
      position: Vector2(size.x - 36, isWeb ? 5 : 2),
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
    subTitle = TextComponent(
      position: Vector2(5, 22),
      size: size,
      text: tutorialOg.state.tutorialStrings[tutorialOg.state.tutorialStep],
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );
    tutorialButton = TutorialButton(
      position: Vector2(size.x / 1.05, size.y / 1.2),
      onPressed: () {},
    );

    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 1,
      bottomHeight: 2,
      leftWidth: 9,
      rightWidth: 9,
    );

    addAll([title, subTitle, tutorialButton, tutorialCountText]);
    return super.onLoad();
  }

  @override
  update(double dt) {
    if (tutorialOg.state.tutorialStep < 7) {
      subTitle.text =
          tutorialOg.state.tutorialStrings[tutorialOg.state.tutorialStep];
      tutorialCountText.text =
          '${tutorialOg.state.tutorialStep + 1} of ${tutorialOg.state.tutorialStrings.length}';
    }
    super.update(dt);
  }

  void moveHud() {
    add(
      MoveToEffect(
        Vector2(position.x + (size.x * 1.5), position.y),
        onComplete: () {
          gameOg.events.pause();
          game.pauseEngine();
          tutorialButton.onReleased = () {
            musicOg.events.playSfx(SfxType.click);

            gameOg.events.resume();
            game.resumeEngine();
            tutorialOg.events.next();
            position = position;
          };
        },

        EffectController(duration: moveEffectDuration),
      ),
    );
    moveEffectDuration = .5;
  }
}
