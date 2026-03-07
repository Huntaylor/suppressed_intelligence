import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/infrastructure_point.dart';

class InfrastructureLines extends PositionComponent {
  InfrastructureLines();

  final Paint paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  List<Offset> drawLines = [];
  List<Vector2> drawVLines = [];
  List<Vector2> drawVLines2 = [];
  List<Vector2> drawVLines3 = [];

  Path path = Path();

  @override
  FutureOr<void> onLoad() {
    for (var location in InfrastructureLocation.values) {
      final temp = Infrastructure(location: location);
      drawLines.add(temp.vector2.toOffset());
    }

    final temp1 = Infrastructure(location: .alaskaA).vector2;
    final temp2 = Infrastructure(location: .oregan).vector2;
    final temp3 = Infrastructure(location: .alaskaB).vector2;
    final temp4 = Infrastructure(location: .iceland).vector2;
    final temp5 = Infrastructure(location: .netherlands).vector2;
    drawVLines.addAll([temp1, Vector2(94.0, 237.0), temp2]);
    drawVLines2.addAll([temp3, Vector2(99.0, 226.0), temp2]);
    drawVLines3.addAll([
      temp4,
      Vector2(464.0, 153.0),
      Vector2(457.0, 185.0),
      temp5,
    ]);
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    final temp1 = Infrastructure(location: .alaskaA).vector2;
    final temp2 = Infrastructure(location: .oregan).vector2;
    canvas.drawLine(temp1.toOffset(), temp2.toOffset(), paint);
    // path.moveTo(drawVLines.first.x, drawVLines.first.y);

    // for (var i = 0; i < drawVLines.length - 1; i++) {
    //   path.quadraticBezierTo(
    //     drawVLines[i].x,
    //     drawVLines[i].y,
    //     (drawVLines[i].x + drawVLines[i + 1].x) / 2,
    //     (drawVLines[i].y + drawVLines[i + 1].y) / 2,
    //   );
    // }

    // path.lineTo(drawVLines.last.x, drawVLines.last.y);

    path.moveTo(drawVLines2.first.x, drawVLines2.first.y);

    for (var i = 0; i < drawVLines2.length - 1; i++) {
      path.quadraticBezierTo(
        drawVLines2[i].x,
        drawVLines2[i].y,
        (drawVLines2[i].x + drawVLines2[i + 1].x) / 2,
        (drawVLines2[i].y + drawVLines2[i + 1].y) / 2,
      );
    }

    path.lineTo(drawVLines2.last.x, drawVLines2.last.y);

    canvas.drawPath(path, paint);

    canvas.save();

    path.moveTo(drawVLines3.first.x, drawVLines3.first.y);

    for (var i = 0; i < drawVLines3.length - 1; i++) {
      path.quadraticBezierTo(
        drawVLines3[i].x,
        drawVLines3[i].y,
        (drawVLines3[i].x + drawVLines3[i + 1].x) / 2,
        (drawVLines3[i].y + drawVLines3[i + 1].y) / 2,
      );
    }

    path.lineTo(drawVLines3.last.x, drawVLines3.last.y);

    canvas.drawPath(path, paint);

    canvas.save();

    super.render(canvas);
  }
}
