import 'package:application/setup.dart';
import 'package:application/src/objects/game_object.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

void main() {
  setupDeps(() => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    gameObject.events.load();
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      // home: MainMenuView(),
      home: GameWidget.controlled(gameFactory: () => SuppressedIntelGame()),
    );
  }
}
