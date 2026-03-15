import 'package:application/application.dart' as application;
import 'package:data/data.dart' as data;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:scoped_deps/scoped_deps.dart';
import 'package:ui/routes/route.dart';

void main() async {
  final getIt = GetIt.asNewInstance();

  data.setup(getIt);
  application.setup(getIt);

  runScoped(
    () => runApp(MainApp(getIt: getIt)),
    values: {...application.providers},
  );
}

class MainApp extends StatefulWidget {
  const MainApp({required this.getIt, super.key});

  final GetIt getIt;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    GameCoordinator.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: GameCoordinator.instance.routeInformationParser,
      routerDelegate: GameCoordinator.instance.routerDelegate,
    );
  }
}
