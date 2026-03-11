import 'dart:async';
import 'dart:typed_data';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class SectorComponent extends SpriteComponent
    with
        HasGameReference<SuppressedIntelGame>,
        HoverCallbacks /*, TapCallbacks */ {
  SectorComponent({required this.sector}) : super(anchor: .center);

  final WorldSectors sector;

  ByteData? _byteData;

  late double strengthInfluenceNumber;
  late TextComponent influenceComponent;

  double _targetOpacity = 0.0;
  final double _fadeSpeed = 3.0;

  bool debugStrength = false;

  @override
  FutureOr<void> onLoad() async {
    debugStrength = true;

    final image = await game.images.load(sector.imagePath);
    sprite = Sprite(image);
    _byteData = await image.toByteData();
    size = Vector2(sector.size.width, sector.size.height);
    position = Vector2(sector.position.x, sector.position.y);

    opacity = 0;

    influenceComponent = TextComponent(
      position: Vector2(size.x / 2, size.y / 2),
      anchor: .center,
      text: '',
      textRenderer: TextPaint(
        style: TextStyle(
          color: Colors.red[900],
          fontSize: 24,
          backgroundColor: Colors.black.withAlpha(150),
        ),
      ),
    );

    add(influenceComponent);

    // add(opacityEffectFadeOut);
    return super.onLoad();
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    if (!super.containsLocalPoint(point)) return false;
    if (_byteData == null) return false;

    final img = sprite!.image;
    final px = (point.x / size.x * img.width).toInt().clamp(0, img.width - 1);
    final py = (point.y / size.y * img.height).toInt().clamp(0, img.height - 1);

    final index = (py * img.width + px) * 4;
    final alpha = _byteData!.getUint8(index + 3);

    return alpha > 10;
  }

  String get _influenceText {
    final oi = strengthInfluenceOg.state.oi;
    final ai = strengthInfluenceOg.state.ai[sector] ?? 0;
    return 'OI: $oi, AI: $ai';
  }

  @override
  void onHoverEnter() {
    if (debugStrength) {
      influenceComponent.text = _influenceText;
    }
    _targetOpacity = 1.0;
  }

  @override
  void onHoverExit() {
    influenceComponent.text = '';
    _targetOpacity = 0.0;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if ((opacity - _targetOpacity).abs() > 0.01) {
      opacity += (_targetOpacity - opacity) * _fadeSpeed * dt;
    } else {
      opacity = _targetOpacity;
    }
  }
}
