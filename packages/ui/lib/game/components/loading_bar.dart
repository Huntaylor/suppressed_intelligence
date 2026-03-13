import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class LoadingBar extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  LoadingBar({super.position, super.priority})
    : super(size: Vector2(199, 16), anchor: .topLeft);

  late Timer timer;

  Vector2 fillBarPosition = Vector2(4, 3.5);

  int count = 0;

  @override
  FutureOr<void> onLoad() async {
    timer = Timer(
      .1,
      onTick: () => createLoadingTick(),
      autoStart: true,
      repeat: true,
    );

    // paint = Paint()..color = Color.fromARGB(255, 1, 0, 128);
    paint = Paint()..color = Color.fromARGB(255, 1, 1, 175);
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

    // final rect = RectangleComponent(
    //   paint: paint,
    //   size: Vector2(4, 8),
    //   position: Vector2(4, 3.5),
    // );

    // final rect2 = RectangleComponent(
    //   paint: paint,
    //   size: Vector2(4, 8),
    //   position: Vector2(rect.size.x + 5, 3.5),
    // );

    // addAll([rect, rect2]);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    timer.update(dt);
    super.update(dt);
  }

  void createLoadingTick() {
    count++;
    if (count >= 33) {
      return;
    }
    final rect = RectangleComponent(
      paint: paint,
      size: Vector2(5, 9),
      position: fillBarPosition,
    );
    add(rect);
    fillBarPosition = Vector2(
      fillBarPosition.x + (rect.size.x + 1),
      fillBarPosition.y,
    );
  }
}
