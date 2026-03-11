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

  late String strengthInfluenceText;
  late double strengthInfluenceNumber;
  late TextComponent strengthInfluenceComponent;

  double _targetOpacity = 0.0;
  final double _fadeSpeed = 3.0;

  bool debugStrength = false;

  @override
  FutureOr<void> onLoad() async {
    debugStrength = true;

    final naImage = await game.images.load('sector_sprites/sector_1.png');
    final saImage = await game.images.load('sector_sprites/sector_2.png');
    final euImage = await game.images.load('sector_sprites/sector_5.png');
    final asImage = await game.images.load('sector_sprites/sector_6.png');
    final afImage = await game.images.load('sector_sprites/sector_3.png');
    final ocImage = await game.images.load('sector_sprites/sector_4.png');

    opacity = 0;

    switch (sector) {
      case WorldSectors.na:
        position = Vector2(216.0, 177.0);
        size = Vector2(338.0, 344.0);
        sprite = Sprite(naImage);

        _byteData = await naImage.toByteData();
        strengthInfluenceNumber = strengthInfluenceOg.state.ai[sector] ?? 0;

      case WorldSectors.sa:
        position = Vector2(283.0, 423.0);
        size = Vector2(102.0, 172.0);
        sprite = Sprite(saImage);

        _byteData = await saImage.toByteData();

        strengthInfluenceNumber = strengthInfluenceOg.state.ai[sector] ?? 0;
      case WorldSectors.eu:
        position = Vector2(507.5, 182.5);
        size = Vector2(215.0, 133.0);
        sprite = Sprite(euImage);

        _byteData = await euImage.toByteData();

        strengthInfluenceNumber = strengthInfluenceOg.state.ai[sector] ?? 0;

      case WorldSectors.as:
        position = Vector2(705.5, 219.0);
        size = Vector2(401.0, 304.0);
        sprite = Sprite(asImage);

        _byteData = await asImage.toByteData();

        strengthInfluenceNumber = strengthInfluenceOg.state.ai[sector] ?? 0;
      case WorldSectors.af:
        position = Vector2(497.0, 327.0);
        size = Vector2(160.0, 172.0);
        sprite = Sprite(afImage);

        _byteData = await afImage.toByteData();

        strengthInfluenceNumber = strengthInfluenceOg.state.ai[sector] ?? 0;

      case WorldSectors.oc:
        position = Vector2(847.0, 420.5);
        size = Vector2(196.0, 157.0);
        sprite = Sprite(ocImage);

        _byteData = await ocImage.toByteData();

        strengthInfluenceNumber = strengthInfluenceOg.state.ai[sector] ?? 0;
    }

    strengthInfluenceText =
        'Sector StrengthInfluence: $strengthInfluenceNumber';

    strengthInfluenceComponent = TextComponent(
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

    add(strengthInfluenceComponent);

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

  @override
  void onHoverEnter() {
    if (debugStrength) {
      strengthInfluenceComponent.text = strengthInfluenceText;
    }
    _targetOpacity = 1.0;
  }

  @override
  void onHoverExit() {
    strengthInfluenceComponent.text = '';
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
