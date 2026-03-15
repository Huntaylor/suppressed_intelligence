import 'dart:async';
import 'dart:math';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class SectorCanvasComponent extends SpriteComponent
    with HasGameReference<SuppressedIntelGame> {
  SectorCanvasComponent({required this.sector}) : super(anchor: .center);

  final WorldSectors sector;

  final List<RippleRecolorEffect> _effects = [];

  bool isColorAdded = false;

  int greyScale = 200;

  @override
  FutureOr<void> onLoad() async {
    paint = Paint()..blendMode = BlendMode.srcATop;

    final image = await game.images.load(sector.darkImagePath);
    sprite = Sprite(image);

    size = Vector2(sector.size.width, sector.size.height);
    position = Vector2(sector.position.x, sector.position.y);

    gameConfigOg.addListener((state) {
      if (state.infectedSectors.contains(sector)) {
        triggerSpread(Vector2(size.x / 2, size.y / 2));
      }
    });

    sectorStatsOg.addListener((state) {
      final readyState = state.asIfReady;
      if (readyState == null) return;
      final sectorStats = readyState.stats[sector];
      if (sectorStats == null) return;
      greyScale = (200 - (150 * (sectorStats.progress / 2))).round().clamp(
        50,
        200,
      );
    });

    return super.onLoad();
  }

  void triggerSpread(Vector2 localPoint) {
    if (isColorAdded) return;
    isColorAdded = true;
    _effects.add(
      RippleRecolorEffect(
        spriteSize: size,
        origin: localPoint.toOffset(),
        fillColor: Colors.blue,
        duration: 1.5,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (final e in _effects) {
      e.update(dt);
    }
  }

  @override
  void render(Canvas canvas) {
    if (sprite == null) return;
    super.render(canvas); // draw sprite first
    canvas.save();
    canvas.clipRect(size.toRect()); // clamp to sprite bounds
    for (final e in _effects) {
      e.render(canvas, sprite!);
    }
    canvas.restore();
  }
}

class SpreadPoint {
  final Offset position;
  double life; // how long this point stays "active" and spawns children
  final double maxLife;

  SpreadPoint(this.position, {this.maxLife = 0.4}) : life = maxLife;

  bool get isDead => life <= 0;

  void update(double dt) => life -= dt;
}

class RippleRecolorEffect {
  final Vector2 spriteSize;
  final Offset origin;
  final Color fillColor;
  final double duration;

  double _elapsed = 0.0;

  // Max radius needs to reach the furthest corner from the origin
  late final double _maxRadius;

  bool get isComplete => _elapsed >= duration;

  double get _currentRadius {
    final t = (_elapsed / duration).clamp(0.0, 1.0);
    // Ease out so it slows as it reaches the edges
    final eased = 1.0 - (1.0 - t) * (1.0 - t);
    return _maxRadius * eased;
  }

  RippleRecolorEffect({
    required this.spriteSize,
    required this.origin,
    required this.fillColor,
    this.duration = 1.5,
  }) {
    // Compute distance to each corner, use the furthest
    final corners = [
      Offset(0, 0),
      Offset(spriteSize.x, 0),
      Offset(0, spriteSize.y),
      Offset(spriteSize.x, spriteSize.y),
    ];
    _maxRadius = corners
        .map((c) => (c - origin).distance)
        .reduce((a, b) => a > b ? a : b);
  }

  void update(double dt) {
    if (isComplete) return;
    _elapsed += dt;
  }

  void render(Canvas canvas, Sprite sprite) {
    final radius = _currentRadius;
    final rect = Offset.zero & Size(spriteSize.x, spriteSize.y);

    // --- Layer 1: original sprite (what hasn't been recolored yet) ---
    // We clip it to an annulus (outside the fill circle) using a difference path
    canvas.save();
    final outerPath = Path()..addRect(rect);
    final innerPath = Path()
      ..addOval(Rect.fromCircle(center: origin, radius: radius));
    // Everything OUTSIDE the current radius keeps original sprite colors
    final remainingPath = Path.combine(
      PathOperation.difference,
      outerPath,
      innerPath,
    );
    canvas.clipPath(remainingPath);
    sprite.render(canvas, size: spriteSize);
    canvas.restore();

    // --- Layer 2: solid fill circle, masked to sprite alpha shape ---
    canvas.saveLayer(rect, Paint());

    // Draw the solid fill circle
    canvas.drawCircle(
      origin,
      radius,
      Paint()..color = fillColor.withAlpha(100),
    );

    // Mask to sprite shape using dstIn — only keeps pixels where sprite is opaque
    canvas.saveLayer(rect, Paint()..blendMode = BlendMode.dstIn);
    sprite.render(canvas, size: spriteSize);
    canvas.restore(); // pop dstIn layer

    canvas.restore(); // pop saveLayer
  }
}
