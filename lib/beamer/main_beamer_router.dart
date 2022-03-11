import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_experiments/beamer/beamer_list_page.dart';

class BeamerRouterApp extends StatelessWidget {
  BeamerRouterApp({Key? key}) : super(key: key);

  late final _delegate = BeamerDelegate(
    initialPath: '/list',
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (_, __, ___) => const BeamerListPage(),
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: _delegate,
    );
  }
}
