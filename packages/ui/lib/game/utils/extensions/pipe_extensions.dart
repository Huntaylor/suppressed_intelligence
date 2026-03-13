import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

extension PipeX on Pipe {
  Path toPath() {
    final p = Path();
    p.moveTo(start.point.x, start.point.y);

    for (var i = 0; i < path.length - 1; i++) {
      final start = path[i];
      final end = path[i + 1];

      p.quadraticBezierTo(
        start.x,
        start.y,
        (start.x + end.x) / 2,
        (start.y + end.y) / 2,
      );
    }

    p.lineTo(end.point.x, end.point.y);
    return p;
  }
}
