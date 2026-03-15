import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class ProgressBar extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  ProgressBar({super.position, super.priority})
    : super(size: Vector2(199, 16), anchor: .topLeft);

  late Timer timer;
  late Timer backwards;

  List<RectangleComponent> loadingBars = [];

  Vector2 fillBarPosition = Vector2(4, 3.5);

  int count = 0;

  @override
  FutureOr<void> onLoad() async {
    // paint = Paint()..color = Color.fromARGB(255, 1, 0, 128);
    paint = Paint()..color = Color.fromARGB(255, 255, 255, 255);
    final nineTileImage = await game.images.load(
      'windows_95_loading_bar_chatgpt.png',
    );

    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 4,
      bottomHeight: 4,
      leftWidth: 4,
      rightWidth: 4,
    );

    return super.onLoad();
  }

  set setProgress(int data) => _setProgressBar(data);

  void removeLoadingTick(int removed) {
    if (removed < 0) {
      return;
    }
    if (removed == 0) {
      for (var i = 0; i < loadingBars.length; i++) {
        final rect = loadingBars.last;
        loadingBars.remove(rect);
        rect.removeFromParent();
        fillBarPosition = Vector2(
          fillBarPosition.x - (rect.size.x + 1),
          fillBarPosition.y,
        );
      }
      return;
    }

    for (var i = 0; i < loadingBars.length - removed; i++) {
      final rect = loadingBars.last;
      loadingBars.remove(rect);
      rect.removeFromParent();
      fillBarPosition = Vector2(
        fillBarPosition.x - (rect.size.x + 1),
        fillBarPosition.y,
      );
    }
  }

  void createLoadingTick(int filled) {
    if (filled >= 33 || filled <= 0) return;
    if (filled <= loadingBars.length) return;

    for (var i = 0; i < filled - loadingBars.length; i++) {
      final rect = RectangleComponent(
        paint: paint,
        size: Vector2(5, 9),
        position: fillBarPosition,
      );
      loadingBars.add(rect);
      fillBarPosition = Vector2(
        fillBarPosition.x + (rect.size.x + 1),
        fillBarPosition.y,
      );
      add(rect);
    }
  }

  void _setProgressBar(int data) {
    final filled = (data / 100 * 32).round();

    final currentProgress = loadingBars.length;
    if (filled != currentProgress) {
      if (filled > currentProgress) {
        createLoadingTick(filled);
      } else if (filled < currentProgress) {
        removeLoadingTick(filled);
      }
    }
  }
}
