import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/input.dart';

class HudUpgradeButton extends HudButtonComponent {
  HudUpgradeButton({super.position, super.size, super.margin, super.onPressed})
    : super(anchor: .topLeft);

  late Vector2 newPosition;

  late MoveToEffect moveToEffect;

  @override
  FutureOr<void> onLoad() async {
    newPosition = Vector2(position.x - 64, position.y);
    moveToEffect = MoveToEffect(newPosition, EffectController(duration: 1));
    // debugMode = true;
    final buttonUpImage = await game.images.load('upgrade_button.png');
    final buttonDownImage = await game.images.load(
      'upgrade_button_pressed.png',
    );

    button = SpriteComponent.fromImage(buttonUpImage);
    buttonDown = SpriteComponent.fromImage(buttonDownImage);

    return super.onLoad();
  }

  Future<void> startGame() async {
    // add(moveToEffect);
  }
}
