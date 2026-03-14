import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class SectorPlacementComponent extends SpriteComponent
    with DragCallbacks, TapCallbacks, HasGameReference<SuppressedIntelGame> {
  SectorPlacementComponent({
    super.sprite,
    super.size,
    super.position,
    super.bleed,
    super.scale,
  }) : super(anchor: .center);

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    priority = 10;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;

    final positionText = Vector2(
      position.x.ceilToDouble(),
      position.y.ceilToDouble(),
    ).toString();

    log(positionText);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    priority = 0;
    _snapToGrid();
  }

  void _snapToGrid() {
    const gridSize = 1.0;
    position = Vector2(
      (position.x / gridSize).round() * gridSize,
      (position.y / gridSize).round() * gridSize,
    );
  }
}
