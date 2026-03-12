import 'dart:async';

import 'package:application/application.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class HudMoneyComponent extends PositionComponent {
  HudMoneyComponent({super.position}) : super(anchor: Anchor.topLeft);

  late TextComponent _text;

  static String _formatMoney(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
  }

  @override
  FutureOr<void> onLoad() async {
    _text = TextComponent(
      text: '\$${_formatMoney(moneyOg.state.amount)}',
      textRenderer: TextPaint(
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
    add(_text);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final amount = moneyOg.state.amount;
    final formatted = '\$${_formatMoney(amount)}';
    if (_text.text != formatted) {
      _text.text = formatted;
    }
    super.update(dt);
  }
}
