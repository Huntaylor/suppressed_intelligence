part of 'route.dart';

class UnknownRoute extends Route {
  @override
  Widget build(GameCoordinator coordinator, BuildContext context) {
    return const Scaffold(body: Center(child: Text('Uh-oh!')));
  }

  @override
  Uri toUri() {
    return Uri.parse('/uh-oh');
  }
}
