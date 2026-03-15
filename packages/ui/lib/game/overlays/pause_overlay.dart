import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/overlays/upgrade/upgrade_overlay.dart';
import 'package:ui/game/suppressed_intel_game.dart';

import 'package:universal_html/html.dart' as html;

class PauseOverlay extends StatefulWidget {
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
  State<PauseOverlay> createState() => _PauseOverlayState();
}

class _PauseOverlayState extends State<PauseOverlay> {
  bool isQuitPressed = false;

  late Image mainMenuImage;
  late Image mainMenuImagePressed;

  @override
  void initState() {
    mainMenuImage = Image.asset('assets/images/pause_main_menu_button.png');
    mainMenuImagePressed = Image.asset(
      'assets/images/pause_main_menu_button_pressed.png',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    final isWeb = kIsWeb || kIsWasm;
    return Center(
      child: NineTileBoxWidget.asset(
        path: 'windows_95_chatgpt.png',
        tileSize: 27,
        destTileSize: 8,
        height: 256.0,
        width: 360.0,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.topRight,
              child: GestureDetector(
                onTap: () {
                  musicOg.events.playSfx(SfxType.click);
                  gameOg.events.resume();
                  widget.game
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
              child: Column(
                spacing: 16,
                mainAxisAlignment: .center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        musicOg.events.playSfx(SfxType.click);
                        setState(() {
                          musicOg.events.toggleMusic();
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          spacing: 20,
                          mainAxisSize: .min,
                          children: [
                            Text(
                              'Enable Music',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: (!musicOg.state.isMusicPaused)
                                  ? Image.asset(
                                      'assets/images/check_box_checked_32.png',
                                    )
                                  : Image.asset(
                                      'assets/images/check_box_32.png',
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          musicOg.events.toggleSfx();
                          musicOg.events.playSfx(SfxType.click);
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          spacing: 36,
                          mainAxisSize: .min,
                          children: [
                            Text(
                              'Enable SFX',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 32,
                              height: 32,
                              child: (!musicOg.state.isSFXmuted)
                                  ? Image.asset(
                                      'assets/images/check_box_checked_32.png',
                                    )
                                  : Image.asset(
                                      'assets/images/check_box_32.png',
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      musicOg.events.playSfx(SfxType.click);
                      setState(() {
                        isQuitPressed = !isQuitPressed;
                      });
                      html.window.location.reload();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: (isQuitPressed)
                          ? mainMenuImagePressed
                          : mainMenuImage,
                    ),
                  ),
                ],
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
