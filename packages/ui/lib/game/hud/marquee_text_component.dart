import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class MarqueeTextComponent extends PositionComponent
    with HasGameReference<SuppressedIntelGame> {
  String _text;
  String get text => _text;

  set text(String value) {
    if (_text == value) return;
    _text = value;
    _textWidth = _measureTextWidth(value);
    _textComponent.text = value;
    _textComponent.position.x = 75;
    _textComponent.position.y = 16;
  }

  final bool isWeb = kIsWasm || kIsWeb;

  final double speed;

  late TextComponent _textComponent;
  double _textWidth = 0;

  MarqueeTextComponent({
    required String text,
    required Vector2 position,
    required Vector2 size,
    this.speed = 45.0,
  }) : _text = text,
       super(position: position, size: size);

  late TextPaint textPaint;

  @override
  Future<void> onLoad() async {
    textPaint = TextPaint(
      style: const TextStyle(fontSize: 12, color: Colors.white),
    );
    _textWidth = _measureTextWidth(text);

    _textComponent = TextComponent(
      text: text,
      textRenderer: textPaint,
      position: Vector2(75, 16),
    );

    await add(
      ClipComponent.rectangle(
        position: Vector2(0, isWeb ? 1 : 2),
        size: Vector2(size.x, size.y - (isWeb ? 17 : 16)),
        children: [_textComponent],
      ),
    );
  }

  double _measureTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: textPaint.style),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_textComponent.position.y.ceil() >= 0) {
      _textComponent.position.y -= speed * dt;
    } else {
      _textComponent.position.x -= speed * dt;
    }

    if (_textComponent.position.x < -_textWidth) {
      _textComponent.position.x = size.x;
    }
  }
}
