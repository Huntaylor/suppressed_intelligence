import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      // home: MainMenuView(),
      home: GameWidget.controlled(gameFactory: () => SuppressedIntelGame()),
    );
  }
}
