part of 'route.dart';

class MainMenuRoute extends Route with RouteRedirect<Route> {
  MainMenuRoute();

  @override
  FutureOr<Route> redirect() {
    if (gameConfigOg.state.hasUserSetName) {
      return GameRoute();
    }
    return this;
  }

  @override
  Widget build(GameCoordinator coordinator, BuildContext context) {
    return MainMenuView();
  }

  @override
  Uri toUri() {
    return Uri.parse('menu');
  }
}
