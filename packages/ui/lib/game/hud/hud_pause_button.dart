import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';

class HudPauseButton extends HudButtonComponent with HoverCallbacks {
  HudPauseButton({super.position, super.size, super.margin, super.onPressed})
    : super(anchor: .topLeft);

  @override
  FutureOr<void> onLoad() async {
    final buttonUpImage = await game.images.load('pause_button.png');
    final buttonDownImage = await game.images.load('pause_button_pressed.png');
    button = SpriteComponent.fromImage(buttonUpImage);
    buttonDown = SpriteComponent.fromImage(buttonDownImage);
    // add(
    //   MoveToEffect(
    //     Vector2(position.x - 64, position.y),
    //     EffectController(duration: 1),
    //   ),
    // );

    return super.onLoad();
  }
}
