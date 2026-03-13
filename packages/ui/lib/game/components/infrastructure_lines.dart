import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/utils/extensions/pipe_extensions.dart';

class InfrastructureLines extends PositionComponent with Snapshot {
  InfrastructureLines() : super(priority: 2);

  @override
  FutureOr<void> onLoad() {
    gameConfigOg.addListener((state) {
      // Trigger snapshot regeneration when sectors change.
      // Do NOT update _infectedSectors here—render() must see the diff to redraw.
      takeSnapshot();
    });
    return super.onLoad();
  }

  /// Soft glow underneath the main line for depth
  final Paint _glowPaint = Paint()
    ..color = const Color(0x15FFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 8
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  /// Main line - slightly softer white, round caps for polished look
  final Paint paint = Paint()
    ..color = const Color(0xE6FFFFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  /// Dots at pipe endpoints
  final Paint _dotPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;

  static const _dotRadius = 2.0;

  Set<WorldSectors> _infectedSectors = {};

  @override
  void render(Canvas canvas) {
    final currentInfectedSectors = gameConfigOg.state.infectedSectors;
    if (!setEquals(_infectedSectors, currentInfectedSectors)) {
      _infectedSectors = currentInfectedSectors;

      final pipes = _getPipesForSectors(_infectedSectors);
      final paths = [for (final pipe in pipes) pipe.toPath()];

      for (var path in paths) {
        canvas.drawPath(path, _glowPaint);
        canvas.drawPath(path, paint);
      }

      final dotPositions = {
        for (final pipe in pipes) ...[pipe.start.point, pipe.end.point],
      };

      for (final point in dotPositions) {
        canvas.drawCircle(Offset(point.x, point.y), _dotRadius, _dotPaint);
      }

      takeSnapshot();
    }

    super.render(canvas);
  }

  Set<Pipe> _getPipesForSectors(Set<WorldSectors> infectedSectors) {
    return {
      for (final sector in infectedSectors)
        ...Pipe.allBySector(sector, includeEnd: false),
    };
  }
}
