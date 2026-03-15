import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';
import 'package:ui/game/utils/extensions/pipe_extensions.dart';

class InfoDotComponent extends CircleComponent
    with HasGameReference<SuppressedIntelGame> {
  InfoDotComponent.normal({
    super.position,
    required this.dot,
    required this.reverse,
    Color color = Colors.white,
    double radius = 3,
  }) : super(
         paint: Paint()..color = color,
         radius: radius,
         anchor: Anchor.center,
       );

  final InfoDot dot;
  final bool reverse;

  @override
  Future<void> onLoad() async {
    priority = game.infoDotsPriority;

    add(
      MoveAlongPathEffect(
        dot.pipe.toPath(reverse: reverse),
        EffectController(duration: dot.pipe.travelTime.inSeconds.toDouble()),
        absolute: true,
        onComplete: () {
          removeFromParent();
          infoDotsOg.events.dropInfoDot(dot);
          sectorStatsOg.events.receiveInfoDot(dot);
          moneyOg.events.addMoney(5);
        },
      ),
    );

    await super.onLoad();
  }
}
