import 'dart:math';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:ui/game/components/bubble_icon.dart';
import 'package:ui/game/components/sector_component.dart';
import 'package:ui/game/suppressed_intel_game.dart';
import 'package:ui/game/utils/sector_bounds.dart';

/// Syncs [sectorBubbleOg] state to bubble icons on the world map.
class SectorBubblesComponent extends Component
    with HasGameReference<SuppressedIntelGame> {
  SectorBubblesComponent() : super(priority: 4);

  final Random _random = Random();
  final Set<int> _renderedIds = {};

  @override
  void update(double dt) {
    super.update(dt);

    final state = sectorBubbleOg.state;
    final currentIds = state.bubbles.map((b) => b.id).toSet();

    final infectedSectors = gameConfigOg.state.infectedSectors;

    for (final id in _renderedIds.toList()) {
      final child = children
          .query<BubbleIcon>()
          .where((c) => c.bubble.id == id)
          .firstOrNull;
      if (child == null) {
        _renderedIds.remove(id);
        continue;
      }
      final remove =
          !currentIds.contains(id) ||
          !infectedSectors.contains(child.bubble.sector);
      if (remove) {
        child.removeFromParent();
        _renderedIds.remove(id);
      }
    }
    for (final bubble in state.bubbles) {
      if (!infectedSectors.contains(bubble.sector)) continue;
      if (!_renderedIds.contains(bubble.id)) {
        final sectorComponent = parent?.children
            .query<SectorComponent>()
            .where((c) => c.sector == bubble.sector)
            .firstOrNull;
        final position = switch ((bubble, sectorComponent)) {
          (SectorBubble(:final position?), _) => Vector2(
            position.x,
            position.y,
          ),
          (_, SectorComponent(:final containsWorldPoint)) =>
            randomPositionInSectorWithinBounds(
              bubble.sector,
              _random,
              containsWorldPoint,
            ),
          _ => randomPositionInSector(bubble.sector, _random),
        };

        add(BubbleIcon(bubble: bubble, position: position));
        _renderedIds.add(bubble.id);
      }
    }
  }
}
