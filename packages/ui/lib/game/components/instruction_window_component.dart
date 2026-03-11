import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class InstructionWindowComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  InstructionWindowComponent({super.position, super.size})
    : super(anchor: Anchor.topCenter, priority: 5);

  late TextComponent aiName;

  final bool isWeb = kIsWasm || kIsWeb;

  @override
  FutureOr<void> onLoad() async {
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

    final instructionText = TextComponent(
      textRenderer: TextPaint(style: TextStyle(fontSize: 16)),
      position: Vector2(size.x / 2, size.y / 3),
      size: Vector2(size.x - 8, size.y),
      text: 'Welcome to Suppressed Intelligence!',
      anchor: .center,
    );
    final instructionText2 = TextComponent(
      textRenderer: TextPaint(style: TextStyle(fontSize: 12)),

      position: Vector2(size.x / 2, size.y / 2),
      size: Vector2(size.x - 8, size.y),
      text:
          'Your task is simple, create a worldwide dependence on AI to win.\nUpgrades are available to boost your LLM.',
      anchor: .center,
    );
    final instructionText3 = TextComponent(
      textRenderer: TextPaint(style: TextStyle(fontSize: 12)),

      position: Vector2(size.x / 2, size.y / 1.5),
      size: Vector2(size.x - 8, size.y),
      text: 'Select a sector to build your initial data center',
      anchor: .center,
    );

    final startImage = await game.images.load('menu_button.png');
    final startImagePressed = await game.images.load('menu_button_pressed.png');

    final button = ButtonComponent(
      anchor: .center,
      position: Vector2(size.x / 2, size.y / 1.2),
      button: SpriteComponent.fromImage(startImage),
      buttonDown: SpriteComponent.fromImage(startImagePressed),
      onPressed: () {
        game.begin();
        removeFromParent();
      },
    );

    addAll([
      instructionText,
      aiName,
      instructionText2,
      instructionText3,
      button,
    ]);

    return super.onLoad();
  }
}
