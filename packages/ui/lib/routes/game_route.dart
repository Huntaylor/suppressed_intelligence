part of 'route.dart';

class GameRoute extends Route {
  GameRoute({this.aiName});

  final String? aiName;

  @override
  Widget build(GameCoordinator coordinator, BuildContext context) {
    return Scaffold(
      body: GameWidget<SuppressedIntelGame>.controlled(
        overlayBuilderMap: {
          'PauseOverlay': (context, game) => PauseOverlay(game: game),
        },
        gameFactory: () => SuppressedIntelGame(aiName: aiName ?? 'ChatGibitty'),
      ),
    );
  }

  @override
  Uri toUri() {
    return Uri.parse('/game');
  }
}
