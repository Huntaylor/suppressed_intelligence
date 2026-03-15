import 'package:application/application.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/overlays/upgrade/upgrade_overlay.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class OiStartOverlay extends StatefulWidget {
  const OiStartOverlay({super.key, required this.game});

  final SuppressedIntelGame game;

  static const id = 'OiStartOverlay';

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
  State<OiStartOverlay> createState() => _OiStartOverlayState();
}

class _OiStartOverlayState extends State<OiStartOverlay> {
  late Image suppressImage;
  late Image suppressImagePressed;
  bool isPressed = false;

  @override
  void initState() {
    suppressImage = Image.asset('assets/images/menu_suppress_button.png');
    suppressImagePressed = Image.asset(
      'assets/images/menu_suppress_button_pressed.png',
    );
    super.initState();
  }

  Image get buttonSprite => isPressed ? suppressImagePressed : suppressImage;

  @override
  Widget build(BuildContext _) {
    final List<String> infoStrings = [
      'An organization named The Original Intelligence, or O.I., has been established.',

      'Their goal is to abolish the use, production, and incorperation of LLMs.',

      'If they reach a worldwide consensus, you will lose.',

      'OI icons will now appear, they can be tapped to slow their movement.',
    ];

    final isWeb = kIsWeb || kIsWasm;
    return Center(
      child: NineTileBoxWidget.asset(
        path: 'windows_95_chatgpt.png',
        tileSize: 27,
        destTileSize: 8,
        height: 320,
        width: 720,
        child: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.topRight,
              child: GestureDetector(
                onTap: () {
                  gameOg.events.resume();
                  OiStartOverlay.hide(widget.game);
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
              alignment: Alignment.center,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: infoStrings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 8),
                    child: Text(
                      infoStrings[index],
                      textAlign: .center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: .bottomCenter,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                  OiStartOverlay.hide(widget.game);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: buttonSprite,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, isWeb ? 3 : 1, 0, 1),
                child: Text(
                  'Some resist the inevitable',
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
