import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class InstructionWindowComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame>, TapCallbacks {
  InstructionWindowComponent({super.position, super.size})
    : super(anchor: Anchor.topCenter);

  late TextComponent aiName;

  final bool isWeb = kIsWasm || kIsWeb;

  final List<String> infoStrings = [
    'Your task is simple, create a worldwide dependence on AI to win.',

    'Upgrades are available to boost your LLM.',

    'Attempt to infiltrate new sectors by tapping on AI Bubbles',

    'Media can be a powerful tool, either for or against you.',

    'Select a sector to build your initial data center',
  ];

  late Vector2 subTextPosition;
  double offsetY = 2.5;

  @override
  FutureOr<void> onLoad() async {
    priority = game.infoWindowPriority;

    final nineTileImage = await game.images.load(
      'windows_95_no_close_chatgpt.png',
    );
    nineTileBox = NineTileBox(
      Sprite(nineTileImage),
      tileSize: 27,
      destTileSize: 8,
    );

    aiName = TextComponent(
      position: Vector2(3, isWeb ? 1.75 : -1),
      text: '${gameConfigOg.state.name} Version',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    );

    final instructionTitle = TextComponent(
      textRenderer: TextPaint(
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      position: Vector2(size.x / 2, size.y / 3.8),
      size: Vector2(size.x - 8, size.y),
      text: 'Welcome to Suppressed Intelligence!',
      anchor: .center,
    );

    double offsetY = (size.y / 3) + 16;
    Vector2 subTextPosition = Vector2(size.x / 2, offsetY);

    for (var string in infoStrings) {
      final tempTextComponent = TextComponent(
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),

        position: subTextPosition,
        size: Vector2(size.x - 8, 16),
        text: string,
        anchor: .center,
      );
      offsetY = offsetY + 18;
      subTextPosition = Vector2(subTextPosition.x, offsetY);
      add(tempTextComponent);
    }

    final startImage = await game.images.load('menu_start_button.png');
    final startImagePressed = await game.images.load(
      'menu_start_button_pressed.png',
    );

    final button = ButtonComponent(
      anchor: .center,
      position: Vector2(size.x / 2, size.y / 1.12),
      button: SpriteComponent.fromImage(startImage),
      buttonDown: SpriteComponent.fromImage(startImagePressed),
      onPressed: () {
        musicOg.events.playSfx(SfxType.click);
        if (tutorialOg.state.enabledTutorial) {
          tutorialOg.events.show();
        }
        game.infoStartUp = false;
        removeFromParent();
      },
    );

    addAll([
      aiName,
      instructionTitle,
      // instructionText2,
      // instructionText3,
      // instructionText4,
      // instructionText5,
      button,
    ]);

    return super.onLoad();
  }
}
