import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/suppressed_intel_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: GameWidget.controlled(gameFactory: () => SuppressedIntelGame()),
    );
  }
}
