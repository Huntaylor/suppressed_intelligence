part of 'route.dart';

class GameRoute extends Route {
  GameRoute();

  @override
  Widget build(GameCoordinator coordinator, BuildContext context) {
    return Scaffold(
      body: GameWidget<SuppressedIntelGame>.controlled(
        overlayBuilderMap: {
          'PauseOverlay': (context, game) => PauseOverlay(game: game),
          'UpgradeOverlay': (context, game) => UpgradeOverlay(game: game),
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
