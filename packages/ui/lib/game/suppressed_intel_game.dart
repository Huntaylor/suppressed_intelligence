import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/hud/hud_news_component.dart';
import 'package:ui/game/hud/hud_pause_button.dart';
import 'package:ui/game/hud/hud_upgrade_button.dart';
import 'package:ui/game/world/world.dart';

class SuppressedIntelGame extends FlameGame
    with TapCallbacks, MouseMovementDetector, DragCallbacks, ScrollDetector {
  SuppressedIntelGame();

  Color blueBackground = Color.fromARGB(255, 91, 110, 225);
  Color darkBlueBackground = Color.fromARGB(255, 35, 35, 58);

  late bool debugGame;

  late WorldMap worldMap;

  late TextComponent mouseDebug;
  late TextComponent positionText;

  late String mouseText;

  late Vector2 mousePosition;

  final double gameWidth = 1024;
  final double gameHeight = 515;

  @override
  FutureOr<void> onLoad() async {
    // aiName = 'ChatGibitty';
    debugGame = false;

    mousePosition = Vector2.zero();
    mouseText = 'Initial Text';
    mouseDebug = TextComponent(text: mouseText, priority: 2);

    await images.loadAllImages();

    _cameraSetup();
    if (debugGame) {
      world.add(mouseDebug);
    }

    _intializeGame();
    return super.onLoad();
  }

  @override
  void onMouseMove(PointerHoverInfo info) {
    if (debugGame) {
      final localPosition = camera.globalToLocal(info.eventPosition.global);
      mousePosition = localPosition;
      mouseText = Vector2(
        mousePosition.x.ceilToDouble(),
        mousePosition.y.ceilToDouble(),
      ).toString();
    }

    super.onMouseMove(info);
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (debugGame) {
      positionText = TextComponent(
        anchor: Anchor.bottomCenter,
        textRenderer: TextPaint(
          style: TextPaint.defaultTextStyle.copyWith(
            backgroundColor: Colors.black,
            color: Colors.red,
            fontSize: 8,
          ),
        ),
        text: mouseText,
        priority: 2,
        position: camera.globalToLocal(event.localPosition),
      );
      world.add(positionText);
    }
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    if (debugGame) {
      mouseDebug
        ..position = mousePosition
        ..text = mouseText;
    }

    super.update(dt);
  }

  @override
  Color backgroundColor() => darkBlueBackground;

  void _cameraSetup() {
    worldMap = WorldMap();

    world = worldMap;

    final viewfinder = Viewfinder()..anchor = Anchor.topLeft;
    camera = CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
      world: world,
      viewfinder: viewfinder,
      hudComponents: [
        FpsTextComponent(),
        HudNewsComponent(
          size: Vector2(360, 32),
          position: Vector2(gameWidth / 2, 0),
        ),
        HudPauseButton(
          position: Vector2(gameWidth - 64, 0),
          size: Vector2(30, 28),
          onPressed: () {
            overlays.add('PauseOverlay');
            pauseEngine();
          },
        ),
        HudUpgradeButton(
          position: Vector2(gameWidth - 64, 32),
          size: Vector2(30, 28),
          onPressed: () {
            overlays.add('UpgradeOverlay');
          },
        ),
      ],
    );
  }

  /// Debug Zoom --------
  static const double _minZoom = 0.5;
  static const double _maxZoom = 5.0;
  static const double _zoomSensitivity = 0.001;

  @override
  void onScroll(PointerScrollInfo info) {
    final scrollDelta = info.scrollDelta.global.y;
    final zoomDelta = -scrollDelta * _zoomSensitivity;

    if (debugGame) {
      _zoomAtPoint(
        zoomDelta: zoomDelta,
        screenPoint: info.eventPosition.global,
      );
    }
  }

  void _zoomAtPoint({required double zoomDelta, required Vector2 screenPoint}) {
    final currentZoom = camera.viewfinder.zoom;
    final newZoom = (currentZoom + zoomDelta * currentZoom).clamp(
      _minZoom,
      _maxZoom,
    );

    // Convert screen point to world position BEFORE zoom change
    final worldPoint = camera.globalToLocal(screenPoint);

    // Apply new zoom
    camera.viewfinder.zoom = newZoom;

    // Recalculate where that world point now appears on screen
    // and shift camera so it stays under the mouse
    final newScreenPoint = camera.localToGlobal(worldPoint);
    final offset = (screenPoint - newScreenPoint);

    camera.viewfinder.position -= offset / newZoom;
  }

  ///-------

  void _intializeGame() {
    if (gameConfigOg.state.infectedSectors.isEmpty) {}
  }
}
