import 'dart:async';
import 'dart:ui';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class ProgressBar extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  ProgressBar({super.position, super.priority})
    : super(size: Vector2(199, 16), anchor: .topLeft);

  late Timer timer;
  late Timer backwards;

  // double progress = 0;

  List<RectangleComponent> loadingBars = [];

  Vector2 fillBarPosition = Vector2(4, 3.5);

  int count = 0;

  @override
  FutureOr<void> onLoad() async {
    // timer = Timer(
    //   .1,
    //   onTick: () => createLoadingTick(),
    //   autoStart: true,
    //   repeat: true,
    // );
    // backwards = Timer(
    //   .1,
    //   onTick: () => removeLoadingTick(),
    //   autoStart: false,
    //   repeat: true,
    // );

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

    strengthInfluenceOg.addListener((state) {
      final data = state.overallAi;

      final filled = (data / 100 * 32).round();

      final currentProgress = loadingBars.length;
      if (filled != currentProgress) {
        if (filled > currentProgress) {
          createLoadingTick(filled);
        } else if (filled < currentProgress) {
          removeLoadingTick(filled);
        }
      }
    });

    return super.onLoad();
  }

  // @override
  // void update(double dt) {
  //   backwards.update(dt);
  //   timer.update(dt);
  //   super.update(dt);
  // }

  void removeLoadingTick(int filled) {
    // count--;
    if (filled <= 0) {
      return;
    }

    final rect = loadingBars.last;

    loadingBars.remove(rect);
    rect.removeFromParent();
    fillBarPosition = Vector2(
      fillBarPosition.x - (rect.size.x + 1),
      fillBarPosition.y,
    );
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
}
