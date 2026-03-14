import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';
import 'package:ui/game/utils/extensions/pipe_extensions.dart';

class PipesComponent extends PositionComponent
    with Snapshot, HasGameReference<SuppressedIntelGame> {
  PipesComponent() : super(priority: 2);

  @override
  FutureOr<void> onLoad() {
    gameConfigOg.addListener((_) {
      // Snapshot will be invalidated from update() when we detect the diff.
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

  Set<WorldSectors> _paintedSectors = {};
  bool _needsRedraw = false; // Start true so we draw on first frame

  @override
  void update(double dt) {
    super.update(dt);
    final currentInfectedSectors = gameConfigOg.state.infectedSectors;
    if (!setEquals(_paintedSectors, currentInfectedSectors)) {
      _paintedSectors = currentInfectedSectors;
      _needsRedraw = true;
      takeSnapshot();
    }
  }

  @override
  void render(Canvas canvas) {
    if (_needsRedraw) {
      _needsRedraw = false;
      _drawPipesAndDots(canvas);
      takeSnapshot();
    }
    super.render(canvas);
  }

  void _drawPipesAndDots(Canvas canvas) {
    final pipes = _getPipesForSectors(_paintedSectors);
    final paths = [for (final pipe in pipes) pipe.toPath()];

    for (final path in paths) {
      canvas.drawPath(path, _glowPaint);
      canvas.drawPath(path, paint);
    }

    final dots = [
      for (final pipe in pipes) ...[pipe.start, pipe.end],
    ];

    for (final dot in dots) {
      final point = dot.point;
      canvas.drawCircle(
        Offset(point.x, point.y),
        2,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
      );

      if (game.debugGame) {
        final textPainter = TextPainter(
          text: TextSpan(
            text: dot.debugName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              backgroundColor: Colors.black.withAlpha(180),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(
          canvas,
          Offset(point.x + 4, point.y - textPainter.height / 2),
        );
      }
    }
  }

  /// Force pipes to repaint on next render (e.g. after path changes).
  void repaint() {
    _paintedSectors = {};
    _needsRedraw = true;
    takeSnapshot();
  }

  Set<Pipe> _getPipesForSectors(Set<WorldSectors> infectedSectors) {
    return {for (final sector in infectedSectors) ...Pipe.allBySector(sector)};
  }
}
