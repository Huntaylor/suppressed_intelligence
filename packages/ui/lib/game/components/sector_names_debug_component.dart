import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

/// Displays sector names at the center of each sector when [debugGame] is true.
class SectorNamesDebugComponent extends Component
    with HasGameReference<SuppressedIntelGame> {
  @override
  Future<void> onLoad() async {
    for (final sector in WorldSectors.values) {
      final text = TextComponent(
        position: Vector2(sector.position.x, sector.position.y),
        anchor: Anchor.center,
        text: sector.displayName,
        textRenderer: TextPaint(
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            backgroundColor: Colors.black.withAlpha(180),
          ),
        ),
        priority: 2,
      );
      add(text);
    }
    return super.onLoad();
  }
}
