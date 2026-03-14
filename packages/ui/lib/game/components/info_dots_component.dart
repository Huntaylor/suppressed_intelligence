import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/info_dot_component.dart';
import 'package:ui/game/suppressed_intel_game.dart';

/// Syncs [infoDotsOg] state to info dot components on the world map.
class InfoDotsComponent extends PositionComponent
    with HasGameReference<SuppressedIntelGame> {
  InfoDotsComponent() : super(priority: 4, position: Vector2.zero());

  final Set<int> _spawnedIds = {};

  @override
  void update(double dt) {
    super.update(dt);

    final dots = infoDotsOg.state.asIfVisibleDots?.dots;

    if (dots == null) {
      return;
    }

    final currentIds = dots.map((d) => d.id).toSet();
    _spawnedIds.removeWhere((id) => !currentIds.contains(id));

    for (final dot in dots) {
      if (_spawnedIds.contains(dot.id)) continue;

      final (:startingPoint, :reverse) = switch (dot) {
        InfoDot(:final fromSector, pipe: Pipe(:final start))
            when start.sector == fromSector =>
          (startingPoint: start.point, reverse: false),
        InfoDot(:final fromSector, pipe: Pipe(:final end))
            when end.sector == fromSector =>
          (startingPoint: end.point, reverse: true),
        _ => (startingPoint: null, reverse: false),
      };

      if (startingPoint == null) continue;

      final hasBehavioralModeling = upgradesOg.state.hasPurchased(
        ResearchDevelopmentUpgrade.behavioralModeling,
      );
      final hasSentimentAnalysis = upgradesOg.state.hasPurchased(
        ResearchDevelopmentUpgrade.sentimentAnalysis,
      );
      add(
        InfoDotComponent.normal(
          position: Vector2(startingPoint.x, startingPoint.y),
          reverse: reverse,
          dot: dot,
          color: hasBehavioralModeling ? Colors.purple : Colors.white,
          radius: hasSentimentAnalysis ? 5 : 3,
        ),
      );
      _spawnedIds.add(dot.id);
    }
  }
}
