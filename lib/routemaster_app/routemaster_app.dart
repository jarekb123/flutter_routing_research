import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:router_experiments/routemaster_app/details_page.dart';
import 'package:router_experiments/routemaster_app/list_page.dart';

class RoutemasterApp extends StatefulWidget {
  const RoutemasterApp({Key? key}) : super(key: key);

  @override
  State<RoutemasterApp> createState() => _RoutemasterAppState();
}

class _RoutemasterAppState extends State<RoutemasterApp> {
  final routeMap = RouteMap(routes: {
    '/': (_) => const Redirect('/list'),
    '/list': (_) => const TabPage(
          child: ListPage(),
          paths: ['/1'],
        ),
    '/list/1': (route) {
      var id = route.pathParameters['id'];

      return MaterialPage(
        child: id != null ? const DetailsPage(index: 1) : const SizedBox(),
      );
    },
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => routeMap,
      ),
      routeInformationParser: RoutemasterParser(),
      routeInformationProvider: PlatformRouteInformationProvider(
        initialRouteInformation: RouteInformation(location: '/'),
      ),
    );
  }
}

