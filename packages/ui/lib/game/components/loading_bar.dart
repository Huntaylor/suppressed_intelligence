import 'dart:async';

import 'package:flame/components.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class LoadingBar extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  LoadingBar({super.position, super.priority})
    : super(size: Vector2(220, 16), anchor: .topLeft);

  @override
  FutureOr<void> onLoad() async {
    final nineTileImage = await game.images.load('windows_95_loading_bar.png');

    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 4,
      bottomHeight: 4,
      leftWidth: 4,
      rightWidth: 4,
    );

    return super.onLoad();
  }
}
