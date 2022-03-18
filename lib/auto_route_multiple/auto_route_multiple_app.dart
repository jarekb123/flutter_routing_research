import 'package:flutter/material.dart';
import 'package:router_experiments/auto_route_multiple/root_routes.gr.dart';

class AutoRouteMultipleApp extends StatelessWidget {
  AutoRouteMultipleApp({Key? key}) : super(key: key);

  final router = RootRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.delegate(),
      routeInformationParser:
          router.defaultRouteParser(includePrefixMatches: true),
    );
  }
}
