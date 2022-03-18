import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_experiments/beamer/beamer_list_page.dart';
import 'package:router_experiments/url_widget/url_widget.dart';

class BeamerRouterApp extends StatelessWidget {
  BeamerRouterApp({Key? key}) : super(key: key);

  late final _delegate = BeamerDelegate(
    initialPath: '/list',
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (_, state, ___) {
          return BeamerListPage();
        },
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(onParse: (info) {
        print(info.location);
        return info;
      }),
      routerDelegate: _delegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(delegate: _delegate),
    );
  }
}
