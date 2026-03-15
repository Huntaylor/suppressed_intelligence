import 'package:application/application.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/overlays/upgrade/upgrade_overlay.dart';
import 'package:ui/game/suppressed_intel_game.dart';

import 'package:universal_html/html.dart' as html;

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({super.key, required this.game});

  final SuppressedIntelGame game;

  static const id = 'PauseOverlay';

  static bool show(SuppressedIntelGame game) {
    if (game.overlays.isActive(id)) return false;

    UpgradeOverlay.hide(game);

    game.pauseEngine();
    gameOg.events.pause();
    game.overlays.add(id);

    return true;
  }

  static bool isShowing(SuppressedIntelGame game) => game.overlays.isActive(id);

  static bool hide(SuppressedIntelGame game) {
    if (!game.overlays.isActive(id)) return false;

    gameOg.events.resume();
    game.resumeEngine();
    game.overlays.remove(id);

    return true;
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
        width: 720,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.topRight,
              child: GestureDetector(
                onTap: () {
                  gameOg.events.resume();
                  game
                    ..overlays.remove('PauseOverlay')
                    ..resumeEngine();
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
              child: ElevatedButton(
                onPressed: () => html.window.location.reload(),
                child: Text(
                  'Main Menu',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, isWeb ? 3 : 1, 0, 1),
                child: Text(
                  'Pause',
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
