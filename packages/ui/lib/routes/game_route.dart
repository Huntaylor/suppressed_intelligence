part of 'route.dart';

class GameRoute extends Route {
  GameRoute();

  @override
  Widget build(GameCoordinator coordinator, BuildContext context) {
    return Scaffold(
      body: GameWidget<SuppressedIntelGame>.controlled(
        overlayBuilderMap: {},
        gameFactory: () {
          return SuppressedIntelGame();
        },
      ),
    );
  }

  @override
  Uri toUri() {
    return Uri.parse('/game');
  }
}
