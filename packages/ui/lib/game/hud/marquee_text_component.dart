import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class MarqueeTextComponent extends PositionComponent
    with HasGameReference<SuppressedIntelGame> {
  final String text;
  final double speed;

  late TextComponent _textComponent;
  double _textWidth = 0;

  MarqueeTextComponent({
    required this.text,
    required Vector2 position,
    required Vector2 size,
    this.speed = 35.0,
  }) : super(position: position, size: size);

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
      position: Vector2(size.x, 0),
    );

    await add(ClipComponent.rectangle(size: size, children: [_textComponent]));
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

    _textComponent.position.x -= speed * dt;

    if (_textComponent.position.x < -_textWidth) {
      _textComponent.position.x = size.x;
    }
  }
}
