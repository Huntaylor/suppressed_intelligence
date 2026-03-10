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
  bool _isHeld = false;

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    priority = 10; // Bring to front while dragging
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta; // Move with finger/mouse

    final positionText = Vector2(
      position.x.ceilToDouble(),
      position.y.ceilToDouble(),
    ).toString();
    // final positiont = game.camera.globalToLocal(event.localEndPosition);
    // final positionText = Vector2(
    //   positiont.x.ceilToDouble(),
    //   positiont.y.ceilToDouble(),
    // ).toString();
    print(positionText);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    priority = 0; // Reset priority after drop
    _snapToGrid(); // Optional: snap logic here
  }

  void _snapToGrid() {
    // Example: snap to 64px grid
    const gridSize = 1.0;
    position = Vector2(
      (position.x / gridSize).round() * gridSize,
      (position.y / gridSize).round() * gridSize,
    );
  }

  // @override
  // void onTapDown(TapDownEvent event) {
  //   _isHeld = !_isHeld;
  //   final position = game.camera.globalToLocal(event.localPosition);
  //   final positionText = Vector2(
  //     position.x.ceilToDouble(),
  //     position.y.ceilToDouble(),
  //   ).toString();
  //   print(positionText);
  // }

  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   if (_isHeld) {
  //     position += event.localDelta;
  //   }
  // }
}
