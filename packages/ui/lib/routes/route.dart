import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/game/suppressed_intel_game.dart';
import 'package:ui/views/main_menu_view.dart';
import 'package:zenrouter/zenrouter.dart';

part 'main_menu_route.dart';
part 'unknown_route.dart';
part 'game_route.dart';

abstract class Route extends RouteTarget with RouteUnique {}

class GameCoordinator extends Coordinator<Route> {
  GameCoordinator._(this._getIt);

  static void initialize(GetIt getIt) {
    if (_instance != null) {
      throw Exception('GameCoordinator already initialized');
    }

    _instance = GameCoordinator._(getIt);
  }

  static GameCoordinator? _instance;
  static GameCoordinator get instance =>
      _instance ?? (throw Exception('GameCoordinator not initialized'));

  final GetIt _getIt;

  @override
  FutureOr<Route> parseRouteFromUri(Uri uri) {
    return switch (uri.pathSegments) {
      ['/menu'] => MainMenuRoute(),
      [] || ['/game'] => GameRoute(),
      _ => UnknownRoute(),
    };
  }
}
