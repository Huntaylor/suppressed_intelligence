import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class BubbleIcon extends SpriteComponent
    with HasGameReference<SuppressedIntelGame>, TapCallbacks {
  BubbleIcon({required this.bubble, required super.position, super.size})
    : super(anchor: Anchor.bottomCenter, priority: 4);

  final SectorBubble bubble;

  late EffectController effectController;

  @override
  FutureOr<void> onLoad() async {
    final iconPath = switch (bubble.type) {
      SectorBubbleType.oi => 'icons/oi_bubble_icon_32x48.png',
      SectorBubbleType.ai => 'icons/ai_bubble_icon_32x48.png',
    };

    final image = await game.images.load(iconPath);
    sprite = Sprite(image);

    effectController = EffectController(duration: .001, reverseDuration: .09);

    final effect = SizeEffect.by(Vector2(0, -64), effectController);
    add(effect);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    add(
      SequenceEffect([
        ScaleEffect.to(Vector2.all(1.6), EffectController(duration: 0.1)),
        ScaleEffect.to(Vector2.all(0.0), EffectController(duration: 0.2)),
      ]),
    );
    add(
      OpacityEffect.to(
        0.0,
        EffectController(duration: 0.15, curve: Curves.easeIn),
      ),
    );
    sectorBubbleOg.events.clickBubble(bubble.id);
    super.onTapDown(event);
  }
}
