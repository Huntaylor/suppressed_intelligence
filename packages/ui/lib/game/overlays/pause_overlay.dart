import 'package:application/application.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class PauseOverlay extends StatelessWidget {
  const PauseOverlay({super.key, required this.game});

  final SuppressedIntelGame game;

  @override
  Widget build(BuildContext _) {
    return Center(
      child: NineTileBoxWidget.asset(
        path: 'windows_95_chatgpt.png',
        tileSize: 27,
        destTileSize: 8,
        height: 512,
        width: 720,
        child: Stack(
          children: [
            // Align(
            //   alignment: Alignment.center,
            //   child: Column(
            //     mainAxisAlignment: .center,
            //     children: [
            //       Text(
            //         'Pause',
            //         style: TextStyle(color: Colors.white, fontSize: 32),
            //       ),
            //     ],
            //   ),
            // ),
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
              alignment: AlignmentGeometry.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, 1, 0, 1),
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
