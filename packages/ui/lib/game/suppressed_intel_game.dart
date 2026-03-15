// ignore_for_file: avoid_print

import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/game/components/instruction_window_component.dart';
import 'package:ui/game/components/pipes_component.dart';
import 'package:ui/game/components/tutorial_info_window_component.dart';
import 'package:ui/game/components/world_info_display.dart';
import 'package:ui/game/hud/hud_money_component.dart';
import 'package:ui/game/hud/hud_news_component.dart';
import 'package:ui/game/hud/hud_pause_button.dart';
import 'package:ui/game/hud/hud_tools_resources_component.dart';
import 'package:ui/game/hud/hud_upgrade_button.dart';
import 'package:ui/game/overlays/game_over_overlay.dart';
import 'package:ui/game/overlays/oi_start_overlay.dart';
import 'package:ui/game/overlays/pause_overlay.dart';
import 'package:ui/game/overlays/upgrade/upgrade_overlay.dart';
import 'package:ui/game/world/world.dart';

class SuppressedIntelGame extends FlameGame
    with
        TapCallbacks,
        MouseMovementDetector,
        DragCallbacks,
        ScrollDetector,
        KeyboardEvents {
  SuppressedIntelGame();

  Color blueBackground = Color.fromARGB(255, 91, 110, 225);
  Color darkBlueBackground = Color.fromARGB(255, 35, 35, 58);

  bool debugGame = false;

  late bool infoStartUp;
  late bool oiStart;

  late WorldMap worldMap;

  late TextComponent mouseDebug;

  late HudNewsComponent hudNewsComponent;
  late HudPauseButton hudPauseButton;
  late HudToolsResourcesComponent hudSideWindowComponent;
  late HudMoneyComponent hudMoneyComponent;

  late TutorialInfoWindowComponent tutorialInfoWindow;
  bool showTutorial = false;

  late HudUpgradeButton hudUpgradeButton;
  late WorldInfoDisplay worldInfoDisplay;

  late String mouseText;

  late Vector2 mousePosition;

  final double gameWidth = 1024;
  final double gameHeight = 515;

  //Priorities
  final sectorCanvasPriority = 1;
  final sectorComponentPriority = 2;
  final pipesPriority = 3;
  final infoDotsPriority = 4;
  final sectorBubblesPriority = 4;
  final bubbleIconPriority = 5;
  final infoWindowPriority = 6;

  @override
  FutureOr<void> onLoad() async {
    // await FlameAudio.audioCache.loadAll([
    //   'click.wav',
    //   'monsters_in_my_closet_loop.wav',
    //   'monsters_in_my_closet.wav',
    // ]);

    // add(AudioComponent());

    final isTutorialEnabled = tutorialOg.state.enabledTutorial;
    tutorialInfoWindow = TutorialInfoWindowComponent();

    tutorialInfoWindow.position = Vector2(
      0 - tutorialInfoWindow.size.x,
      (gameHeight / 1.2) - 7,
    );
    if (isTutorialEnabled) {
      tutorialOg.addListener((state) {
        if (state.shouldShowWindow &&
            state.tutorialStep < state.tutorialStrings.length) {
          tutorialInfoWindow.moveHud();

          tutorialInfoWindow.opacity = 1;
          showTutorial = state.shouldShowWindow;
        } else if (!state.shouldShowWindow && tutorialInfoWindow.opacity == 1) {
          tutorialInfoWindow.opacity = 0;
          tutorialInfoWindow.position = Vector2(
            0 - tutorialInfoWindow.size.x,
            (gameHeight / 1.2) - 7,
          );
        }
      });
    }

    infoStartUp = true;
    oiStart = false;
    hudNewsComponent = HudNewsComponent();

    hudMoneyComponent = HudMoneyComponent();

    hudMoneyComponent.position = Vector2(
      176,
      gameHeight + hudMoneyComponent.size.y,
    );

    hudNewsComponent.position = Vector2(
      gameWidth / 2,
      0 - hudNewsComponent.size.y,
    );

    worldInfoDisplay = WorldInfoDisplay();

    worldInfoDisplay.position = Vector2(
      gameWidth / 2,
      gameHeight + worldInfoDisplay.size.y,
    );

    hudUpgradeButton = HudUpgradeButton(
      onPressed: () {
        print(tutorialOg.state.shouldShowWindow);
        if (tutorialOg.state.shouldShowWindow ||
            gameConfigOg.state.gameOverCondition != .none) {
          return;
        }
        musicOg.events.playSfx(SfxType.click);
        if (UpgradeOverlay.isShowing(this)) {
          UpgradeOverlay.hide(this);
        } else {
          UpgradeOverlay.show(this);
        }
      },
    );

    hudPauseButton = HudPauseButton(
      onPressed: () {
        if (tutorialOg.state.shouldShowWindow ||
            gameConfigOg.state.gameOverCondition != .none) {
          return;
        }
        musicOg.events.playSfx(SfxType.click);
        if (PauseOverlay.isShowing(this)) {
          PauseOverlay.hide(this);
        } else {
          PauseOverlay.show(this);
        }
      },
    );

    mousePosition = Vector2.zero();
    mouseText = 'Initial Text';
    mouseDebug = TextComponent(text: mouseText, priority: 2);

    hudSideWindowComponent = HudToolsResourcesComponent(
      hudPauseButton: hudPauseButton,
      hudUpgradeButton: hudUpgradeButton,
    );

    hudSideWindowComponent.position = Vector2(
      gameWidth + hudSideWindowComponent.size.x,
      0,
    );
    // hudSideWindowComponent.position = Vector2(
    //   gameWidth - (hudSideWindowComponent.size.x + 16),
    //   0,
    // );

    await images.loadAllImages();

    _cameraSetup();
    if (debugGame) {
      world.add(mouseDebug);
    }

    gameConfigOg.addListener((state) {
      if (state.isOIPresent && !oiStart) {
        oiStart = true;
        OiStartOverlay.show(this);
        pauseEngine();
      }
      if (state.gameOverCondition != .none) {
        worldInfoDisplay.finalizeScore();
        GameOverOverlay.show(this);
        gameOg.events.pause;
        pauseEngine();
      }
    });

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
    sectorStatsOg.events.removeSelection();

    if (debugGame) {
      print(mouseText);
    }
    super.onTapDown(event);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        if (PauseOverlay.hide(this)) {
          return KeyEventResult.handled;
        }

        if (overlays.isActive('UpgradeOverlay')) {
          overlays.remove('UpgradeOverlay');
          return KeyEventResult.handled;
        }
        sectorStatsOg.events.removeSelection();
        return KeyEventResult.handled;
      }
      if (debugGame && event.logicalKey == LogicalKeyboardKey.keyR) {
        print('--------------------------------');
        world.children.query<PipesComponent>().firstOrNull?.repaint();
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
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
        // FpsTextComponent(),
        hudSideWindowComponent,
        hudNewsComponent,
        hudMoneyComponent,
        worldInfoDisplay,
        tutorialInfoWindow,
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
    gameConfigOg.events.infectFirstSector(firstSector);
    hudNewsComponent.startNews(firstSector: firstSector);
    worldInfoDisplay.displayInfo();
    hudSideWindowComponent.moveHud();
    hudMoneyComponent.moveHud();
    gameTimeOg.events.init();
    sectorBubbleOg.events.init();
    sectorStatsOg.events.init();
  }

  // @override
  // void dispose() {
  //   FlameAudio.bgm.dispose();
  //   super.dispose();
  // }
}
