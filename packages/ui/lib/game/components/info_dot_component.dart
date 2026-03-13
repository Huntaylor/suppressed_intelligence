import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/utils/extensions/pipe_extensions.dart';

class InfoDotComponent extends CircleComponent {
  InfoDotComponent.normal({super.position, required this.dot})
    : super(
        paint: Paint()..color = Colors.white,
        priority: 3,
        radius: 3,
        anchor: Anchor.center,
      );

  final InfoDot dot;

  @override
  Future<void> onLoad() async {
    add(
      MoveAlongPathEffect(
        dot.pipe.toPath(),
        EffectController(duration: dot.pipe.travelTime.inSeconds.toDouble()),
        absolute: true,
        onComplete: () {
          removeFromParent();
          infoDotsOg.events.dropInfoDot(dot);
        },
      ),
    );

    await super.onLoad();
  }
}
