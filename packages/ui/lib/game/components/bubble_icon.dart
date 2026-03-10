import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class BubbleIcon extends SpriteComponent
    with HasGameReference<SuppressedIntelGame>, TapCallbacks {
  BubbleIcon({super.position, super.size, super.priority})
    : super(anchor: Anchor.bottomCenter);

  late EffectController effectController;

  @override
  FutureOr<void> onLoad() async {
    final oiIcon = await game.images.load('icons/oi_bubble_icon.png');
    final aiIcon = await game.images.load('icons/ai_bubble_icon.png');
    final aiBigIcon = await game.images.load('icons/ai_bubble_icon_32x48.png');
    sprite = Sprite(aiBigIcon);

    effectController = EffectController(duration: .001, reverseDuration: .09);

    final effect = SizeEffect.by(Vector2(0, -64), effectController);
    add(effect);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    parent!.remove(this);
    super.onTapDown(event);
  }
}
