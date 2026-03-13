import 'dart:async';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/hud/marquee_text_component.dart';
import 'package:ui/game/suppressed_intel_game.dart';

class HudNewsComponent extends NineTileBoxComponent
    with HasGameReference<SuppressedIntelGame> {
  HudNewsComponent({super.position})
    : super(anchor: Anchor.topCenter, size: Vector2(360, 32));

  static const _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  late TextComponent aiName;
  late TextComponent dateText;
  late TextComponent moneyText;
  late MarqueeTextComponent newsText;

  final bool isWeb = kIsWasm || kIsWeb;

  bool shouldDisplay = false;

  @override
  FutureOr<void> onLoad() async {
    final nineTileImage = await game.images.load(
      'windows_95_no_close_chatgpt.png',
    );
    nineTileBox = NineTileBox.withGrid(
      Sprite(nineTileImage),
      topHeight: 9,
      bottomHeight: 2,
      leftWidth: 9,
      rightWidth: 9,
    );
    return super.onLoad();
  }

  Future<void> startNews({required WorldSectors firstSector}) async {
    aiName = TextComponent(
      position: Vector2(3, isWeb ? 1.75 : -.25),
      text: gameConfigOg.state.name,
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );

    newsText = MarqueeTextComponent(
      position: Vector2(4, isWeb ? 13 : 11),
      size: Vector2(size.x - 8, size.y),
      text: '',
    );

    final time = gameTimeOg.state;
    dateText = TextComponent(
      anchor: Anchor.topRight,
      position: Vector2(size.x - 5, isWeb ? 1.75 : 0),
      text: '${_monthNames[time.month - 1]} ${time.year}',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );

    final amount = moneyOg.state.amount;
    moneyText = TextComponent(
      anchor: Anchor.topRight,
      position: Vector2(size.x - 90, isWeb ? 1.75 : 0),
      text: '\$$amount',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 8, color: Colors.white),
      ),
    );

    add(
      MoveToEffect(
        Vector2(position.x, position.y + size.y),
        EffectController(duration: .5),
        onComplete: () => _displayText(firstSector),
      ),
    );
  }

  @override
  void update(double dt) {
    if (shouldDisplay) {
      if (aiName.text != gameConfigOg.state.name) {
        aiName.text = gameConfigOg.state.name;
      }

      if (newsHeadlineOg.state.asIfReady?.data.headline
          case final String headline) {
        if (newsText.text != headline) {
          newsText.text = headline;
        }
      }

      final time = gameTimeOg.state;
      final dateStr = '${_monthNames[time.month - 1]} ${time.year}';
      if (dateText.text != dateStr) {
        dateText.text = dateStr;
      }

      final amount = moneyOg.state.amount;
      final moneyStr = '\$$amount';
      if (moneyText.text != moneyStr) {
        moneyText.text = moneyStr;
      }
    }
  }

  void _displayText(WorldSectors firstSector) {
    shouldDisplay = true;
    newsHeadlineOg.events.initWithFirstSector(firstSector);

    addAll([newsText, aiName, dateText, moneyText]);
  }
}
