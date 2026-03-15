library upgrade_overlay;

import 'dart:io';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/overlays/pause_overlay.dart';
import 'package:ui/game/suppressed_intel_game.dart';
import 'package:ui/routes/route.dart';

class GameOverOverlay extends StatefulWidget {
  const GameOverOverlay({super.key, required this.game});

  final SuppressedIntelGame game;

  static const id = 'GameOverOverlay';

  static bool show(SuppressedIntelGame game) {
    if (game.overlays.isActive(id)) return false;

    PauseOverlay.hide(game);

    game.overlays.add(id);
    return true;
  }

  static bool isShowing(SuppressedIntelGame game) => game.overlays.isActive(id);

  static bool hide(SuppressedIntelGame game) {
    if (!game.overlays.isActive(id)) return false;

    game.overlays.remove(id);
    return true;
  }

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  late GameOverCondition gameOverCondition;

  late String aiName;

  late String windowTitle;
  late String contextTitle;
  late String contextSubtitle;

  @override
  void initState() {
    gameOverCondition = gameConfigOg.state.gameOverCondition;
    aiName = gameConfigOg.state.name;

    _setUpStrings();
    super.initState();
  }

  void _setUpStrings() {
    switch (gameOverCondition) {
      case GameOverCondition.win:
        windowTitle = aiName;
        contextTitle = 'Victory!';
        contextSubtitle = 'You won, congradulations!';
      case GameOverCondition.lose:
        windowTitle = 'The Original Intelligence Organization';
        contextTitle = 'Defeat';
        contextSubtitle = 'AI is no more';
      case GameOverCondition.none:
        windowTitle = '';
        contextTitle = '';
        contextSubtitle = '';
    }
  }

  @override
  Widget build(BuildContext _) {
    final isWeb = kIsWeb || kIsWasm;

    return Center(
      child: NineTileBoxWidget.asset(
        path: 'windows_95_chatgpt.png',
        tileSize: 27,
        destTileSize: 8,
        height: 512,
        width: 920,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.topRight,
              child: GestureDetector(
                onTap: () {
                  GameCoordinator.instance.navigate(MainMenuRoute());
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                    width: 15,
                    height: 14,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Align(
              alignment: .center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      contextTitle,
                      textAlign: .center,
                      style: TextStyle(fontSize: 36, color: Colors.white),
                    ),
                    Text(
                      contextSubtitle,
                      textAlign: .center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, isWeb ? 3 : 1, 0, 1),
                child: Text(
                  windowTitle,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
