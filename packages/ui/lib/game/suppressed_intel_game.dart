import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/components/instruction_window_component.dart';
import 'package:ui/game/components/world_info_display.dart';
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

  late bool infoStartUp;

  late WorldMap worldMap;

  late TextComponent mouseDebug;
  late TextComponent positionText;

  late HudNewsComponent hudNewsComponent;

  late HudUpgradeButton hudUpgradeButton;
  late WorldInfoDisplay worldInfoDisplay;

  late String mouseText;

  late Vector2 mousePosition;

  final double gameWidth = 1024;
  final double gameHeight = 515;

  @override
  FutureOr<void> onLoad() async {
    infoStartUp = true;
    hudNewsComponent = HudNewsComponent(
      size: Vector2(360, 32),
      position: Vector2(gameWidth / 2, -64),
    )..opacity = 0;

    worldInfoDisplay = WorldInfoDisplay(
      size: Vector2(360, 32),
      position: Vector2(gameWidth / 2, gameHeight + 32),
    );

    hudUpgradeButton = HudUpgradeButton(
      position: Vector2(gameWidth, 32),
      size: Vector2(30, 28),
      onPressed: () {
        if (overlays.isActive('PauseOverlay')) {
          gameOg.events.pause();
          overlays
            ..remove('PauseOverlay')
            ..add('UpgradeOverlay');
          resumeEngine();
        } else if (overlays.isActive('UpgradeOverlay')) {
          overlays.remove('UpgradeOverlay');
        } else {
          overlays.add('UpgradeOverlay');
        }
      },
    );

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

    final viewfinder = Viewfinder()
      ..anchor = Anchor.topLeft
      ..position = Vector2(-48, -32)
      ..zoom = .95;

    camera = CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
      world: world,
      viewfinder: viewfinder,
      hudComponents: [
        FpsTextComponent(),
        hudNewsComponent,
        HudPauseButton(
          position: Vector2(gameWidth, 0),
          size: Vector2(30, 28),
          onPressed: () {
            if (overlays.isActive('UpgradeOverlay')) {
              gameOg.events.pause();
              overlays
                ..remove('UpgradeOverlay')
                ..add('PauseOverlay');
              pauseEngine();
            } else if (overlays.isActive('PauseOverlay')) {
              gameOg.events.resume();
              overlays.remove('PauseOverlay');
              resumeEngine();
            } else {
              gameOg.events.pause();
              overlays.add('PauseOverlay');
              pauseEngine();
            }
          },
        ),
        hudUpgradeButton,
        worldInfoDisplay,
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
    if (gameConfigOg.state.infectedSectors.isEmpty) {
      final intro = InstructionWindowComponent(
        size: Vector2(360, 220),
        position: Vector2(gameWidth / 2, gameHeight / 5),
      );

      world.add(intro);
    }
  }

  void begin({required WorldSectors firstSector}) {
    worldMap.timer.start();
    gameConfigOg.events.infectFirstSector(firstSector);
    hudNewsComponent.startNews(firstSector: firstSector);
    worldInfoDisplay.displayInfo();
    hudUpgradeButton.startGame();

    gameTimeOg.events.init();
    sectorBubbleOg.events.init();
    sectorStatsOg.events.init();
  }
}
