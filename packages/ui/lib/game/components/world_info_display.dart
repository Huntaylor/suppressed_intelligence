import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';

class WorldInfoDisplay extends NineTileBoxComponent with HasGameReference {
  WorldInfoDisplay({super.position, super.size})
    : super(anchor: Anchor.topCenter);

  late TextComponent aiName;

  final bool isWeb = kIsWasm || kIsWeb;

  late Vector2 newPosition;

  double speed = 45.0;

  @override
  FutureOr<void> onLoad() async {
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
    return super.onLoad();
  }

  void displayInfo() {
    add(MoveToEffect(Vector2(512.0, 483), EffectController(duration: 1)));
  }
}
