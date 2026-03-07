part of 'route.dart';

class MainMenuRoute extends Route {
  MainMenuRoute();

  @override
  Widget build(GameCoordinator coordinator, BuildContext context) {
    return MainMenuView();
  }

  @override
  Uri toUri() {
    return Uri.parse('/menu');
  }
}
