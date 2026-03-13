import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class HudPauseButton extends ButtonComponent
    with HasGameReference<SuppressedIntelGame> {
  HudPauseButton({super.position, super.onPressed})
    : super(anchor: .topLeft, size: Vector2(30, 28));

  @override
  FutureOr<void> onLoad() async {
    final buttonUpImage = await game.images.load('pause_button.png');
    final buttonDownImage = await game.images.load('pause_button_pressed.png');
    button = SpriteComponent.fromImage(buttonUpImage);
    buttonDown = SpriteComponent.fromImage(buttonDownImage);

    return super.onLoad();
  }

  void moveHud() {
    add(
      MoveToEffect(
        Vector2(position.x - (size.x * 2), position.y),
        EffectController(duration: .5),
      ),
    );
  }
}
