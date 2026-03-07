import 'package:application/application.dart' as application;
import 'package:data/data.dart' as data;
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_deps/scoped_deps.dart';
import 'package:ui/game/suppressed_intel_game.dart';

void main() {
  final getIt = GetIt.asNewInstance();
  data.setup(getIt);
  application.setup(getIt);

  runScoped(() => runApp(const MainApp()), values: {...application.providers});
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
