import 'package:application/application.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/overlays/widgets/upgrade_button.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class UpgradeOverlay extends StatefulWidget {
  const UpgradeOverlay({super.key, required this.game});

  final SuppressedIntelGame game;

  @override
  State<UpgradeOverlay> createState() => _UpgradeOverlayState();
}

class _UpgradeOverlayState extends State<UpgradeOverlay> {
  late Image ramImage;
  late Image ramImagePressed;
  late Image searchImage;
  late Image searchImagePressed;
  late Image powerImage;
  late Image powerImagePressed;

  bool isRamPressed = false;
  bool isSearchedPressed = false;
  bool isClosePressed = false;

  @override
  void initState() {
    ramImage = Image.asset('assets/images/ram_button.png');
    ramImagePressed = Image.asset('assets/images/ram_button_pressed.png');

    searchImage = Image.asset('assets/images/search_button.png');
    searchImagePressed = Image.asset('assets/images/search_button_pressed.png');

    powerImage = Image.asset('assets/images/power_button.png');
    powerImagePressed = Image.asset('assets/images/power_button_pressed.png');
    super.initState();
  }

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
            Align(
              alignment: Alignment.center,
              child: Row(
                spacing: 16,
                mainAxisAlignment: .center,
                children: [
                  UpgradeButton(
                    button: ramImage,
                    buttonPressed: ramImagePressed,
                    buttonLabel: 'Better Hardware',
                    width: 72,
                    height: 28,
                  ),
                  VerticalDivider(indent: 32, endIndent: 8),
                  UpgradeButton(
                    button: searchImage,
                    buttonPressed: searchImagePressed,
                    buttonLabel: 'Research and Development',
                    width: 36,
                    height: 28,
                  ),
                  VerticalDivider(indent: 32, endIndent: 8),
                  UpgradeButton(
                    button: powerImage,
                    buttonPressed: powerImagePressed,
                    buttonLabel: 'Increase Available Energy',
                    width: 36,
                    height: 28,
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: GestureDetector(
                onTap: () => widget.game.overlays.remove('UpgradeOverlay'),
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
                  'Upgrade ${gameConfigOg.state.name}',
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
