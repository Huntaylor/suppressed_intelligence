import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ui/game/overlays/pause_overlay.dart';
import 'package:ui/game/overlays/upgrade_overlay.dart';
import 'package:ui/game/suppressed_intel_game.dart';
import 'package:ui/views/main_menu_view.dart';
import 'package:zenrouter/zenrouter.dart';

part 'game_route.dart';
part 'main_menu_route.dart';

abstract class Route extends RouteTarget with RouteUnique {}

class GameCoordinator extends Coordinator<Route> {
  GameCoordinator._();

  static void initialize() {
    if (_instance != null) {
      throw Exception('GameCoordinator already initialized');
    }

    _instance = GameCoordinator._();
  }

  static GameCoordinator? _instance;
  static GameCoordinator get instance =>
      _instance ?? (throw Exception('GameCoordinator not initialized'));

  @override
  DefaultTransitionStrategy get transitionStrategy =>
      DefaultTransitionStrategy.none;

  @override
  FutureOr<Route> parseRouteFromUri(Uri uri) {
    return switch (uri.pathSegments) {
      [] || ['menu'] => MainMenuRoute(),
      ['game'] => GameRoute(),
      _ => MainMenuRoute(),
    };
  }
}
