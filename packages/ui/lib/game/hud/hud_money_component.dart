import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class HudMoneyComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  HudMoneyComponent({super.position})
    : super(anchor: Anchor.topLeft, size: Vector2(74, 30));

  late TextComponent _text;

  late TextComponent title;

  final bool isWeb = kIsWasm || kIsWeb;

  static String _formatMoney(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  @override
  FutureOr<void> onLoad() async {
    final nineTileImage = await game.images.load(
      'windows_95_no_close_chatgpt_thin.png',
    );
    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 8,
      bottomHeight: 2,
      leftWidth: 9,
      rightWidth: 9,
    );

    title = TextComponent(
      position: Vector2(3, isWeb ? 2 : .25),
      text: 'Income',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );

    _text = TextComponent(
      position: Vector2(3, 11),
      text: '\$${_formatMoney(moneyOg.state.amount)}',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
    addAll([_text, title]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final amount = moneyOg.state.amount;
    final formatted = '\$${_formatMoney(amount)}';
    if (_text.text != formatted) {
      _text.text = formatted;
    }
    super.update(dt);
  }

  void moveHud() {
    add(
      MoveToEffect(
        Vector2(position.x, position.y - (size.y * 2)),
        EffectController(duration: .5),
      ),
    );
  }
}
