import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:router_experiments/beamer/details_page.dart';

class BeamerListApp extends StatelessWidget {
  BeamerListApp({Key? key}) : super(key: key);

  final delegate = BeamerDelegate(
    locationBuilder: (routeInfo, __) => AppLocation(routeInfo),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: delegate,
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: delegate,
      ),
    );
  }
}

class AppLocation extends BeamLocation<BeamState> {
  AppLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('home'),
        child: AppRouter(),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/*'];
}

class AppRouter extends StatelessWidget {
  AppRouter({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
    initialPath: '/',
    locationBuilder: (routeInformation, _) => ListLocation(routeInformation),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Beamer(
        routerDelegate: routerDelegate,
      ),
    );
  }
}

class ListLocation extends BeamLocation<BeamState> {
  ListLocation(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: ValueKey('list'),
        title: 'Books',
        type: BeamPageType.noTransition,
        child: ListPage(),
      ),
      if (state.pathParameters.containsKey('id'))
        BeamPage(
          key: ValueKey('details-${state.pathParameters['id']}'),
          child: DetailsPage(
            index: int.parse(state.pathParameters['id']!),
          ),
        ),
    ];
  }

  @override
  List<String> get pathPatterns => ['/:id'];
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Item $index'),
          onTap: () => context.beamToNamed(
            '/$index',
            replaceRouteInformation: true,
          ),
        );
      },
    );
  }
}
