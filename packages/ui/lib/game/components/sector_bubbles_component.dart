import 'dart:math';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:ui/game/components/bubble_icon.dart';
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

    for (final id in _renderedIds.toList()) {
      if (!currentIds.contains(id)) {
        final child = children.query<BubbleIcon>().where((c) => c.bubble.id == id).first;
        child.removeFromParent();
        _renderedIds.remove(id);
      }
    }

    for (final bubble in state.bubbles) {
      if (!_renderedIds.contains(bubble.id)) {
        final position =
            randomPositionInSector(bubble.sector, _random);
        add(BubbleIcon(bubble: bubble, position: position));
        _renderedIds.add(bubble.id);
      }
    }
  }
}
