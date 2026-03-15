library upgrade_overlay;

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/overlays/pause_overlay.dart';
import 'package:ui/game/suppressed_intel_game.dart';

part 'components/__button.dart';
part 'components/__category_widget.dart';
part 'components/__upgrade_button.dart';
part 'components/__upgrade_section.dart';
part 'components/__upgrade_slot.dart';

class UpgradeOverlay extends StatefulWidget {
  const UpgradeOverlay({super.key, required this.game});

  final SuppressedIntelGame game;

  static const id = 'UpgradeOverlay';

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

  int totalMoney = 0;

  @override
  void initState() {
    ramImage = Image.asset('assets/images/ram_button.png');
    ramImagePressed = Image.asset('assets/images/ram_button_pressed.png');

    searchImage = Image.asset('assets/images/search_button.png');
    searchImagePressed = Image.asset('assets/images/search_button_pressed.png');

    powerImage = Image.asset('assets/images/power_button.png');
    powerImagePressed = Image.asset('assets/images/power_button_pressed.png');

    totalMoney = moneyOg.state.amount;

    moneyOg.addListener((state) {
      setState(() {
        totalMoney = state.amount;
      });
    });
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
        height: 512,
        width: 920,
        child: Stack(
          children: [
            Align(alignment: Alignment.center, child: _UpgradeCategoryWidget()),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: GestureDetector(
                onTap: () {
                  musicOg.events.playSfx(SfxType.click);
                  UpgradeOverlay.hide(widget.game);
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
              alignment: .bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '\$$totalMoney',
                  style: TextStyle(color: Colors.white, fontSize: 32),
                ),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(3, isWeb ? 3 : 1, 0, 1),
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
