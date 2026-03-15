part of 'route.dart';

class GameRoute extends Route with RouteRedirect<Route> {
  GameRoute();

  @override
  FutureOr<Route> redirect() {
    if (!gameConfigOg.state.hasUserSetName) {
      return MainMenuRoute();
    }
    return this;
  }

  @override
  Widget build(GameCoordinator coordinator, BuildContext context) {
    return Scaffold(
      body: GameWidget<SuppressedIntelGame>.controlled(
        overlayBuilderMap: {
          OiStartOverlay.id: (context, game) => OiStartOverlay(game: game),
          PauseOverlay.id: (context, game) => PauseOverlay(game: game),
          UpgradeOverlay.id: (context, game) => UpgradeOverlay(game: game),
          GameOverOverlay.id: (context, game) => GameOverOverlay(game: game),
        },
        gameFactory: () => SuppressedIntelGame(),
      ),
    );
  }

  @override
  Uri toUri() {
    return Uri.parse('/game');
  }
}
