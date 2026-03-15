import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class TutorialButton extends ButtonComponent
    with HasGameReference<SuppressedIntelGame> {
  TutorialButton({super.position, super.onPressed})
    : super(anchor: .center, size: Vector2(86, 28));

  late Vector2 newPosition;

  @override
  FutureOr<void> onLoad() async {
    newPosition = Vector2(position.x - (size.x * 2), position.y);
    final buttonUpImage = await game.images.load('next_button.png');
    final buttonDownImage = await game.images.load('next_button_pressed.png');

    button = SpriteComponent.fromImage(buttonUpImage);
    buttonDown = SpriteComponent.fromImage(buttonDownImage);

    return super.onLoad();
  }
}
