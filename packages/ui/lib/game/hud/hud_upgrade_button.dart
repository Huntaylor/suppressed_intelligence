import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class HudUpgradeButton extends ButtonComponent
    with HasGameReference<SuppressedIntelGame> {
  HudUpgradeButton({super.position, super.onPressed})
    : super(anchor: .topLeft, size: Vector2(30, 28));

  late Vector2 newPosition;

  late MoveToEffect moveToEffect;

  @override
  FutureOr<void> onLoad() async {
    newPosition = Vector2(position.x - (size.x * 2), position.y);
    moveToEffect = MoveToEffect(newPosition, EffectController(duration: .5));
    final buttonUpImage = await game.images.load('upgrade_button.png');
    final buttonDownImage = await game.images.load(
      'upgrade_button_pressed.png',
    );

    button = SpriteComponent.fromImage(buttonUpImage);
    buttonDown = SpriteComponent.fromImage(buttonDownImage);

    return super.onLoad();
  }

  Future<void> moveHud() async {
    add(moveToEffect);
  }
}
