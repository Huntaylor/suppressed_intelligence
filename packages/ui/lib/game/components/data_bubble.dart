import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class DataBubble extends CircleComponent {
  DataBubble({
    super.position,
    super.anchor,
    super.radius,
    required this.dataPaths,
  }) : super(paint: Paint()..color = Colors.white, priority: 3);

  List<Path> dataPaths;

  final rnd = Random();

  @override
  Future<void> onLoad() {
    final path = dataPaths[rnd.nextInt(dataPaths.length)];

    final pathing = MoveAlongPathEffect(
      path,
      EffectController(duration: 5),
      onComplete: () => removeFromParent(),
    );

    add(pathing);
    return super.onLoad();
  }
}
