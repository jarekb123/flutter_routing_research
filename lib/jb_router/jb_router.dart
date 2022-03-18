import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JBRouteInfo {
  final String path;

  JBRouteInfo({
    required this.path,
  });
}

class JBPageRoute {
  final String path;
  final WidgetBuilder page;

  final List<JBPageRoute> subroutes;

  JBPageRoute({
    required this.path,
    required this.page,
    this.subroutes = const [],
  });
}

class JBRouterDelegate extends RouterDelegate<JBRouteInfo>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final List<JBPageRoute> routes;
  final Widget Function(BuildContext context, String path) notFoundPageBuilder;
  final String initialPath;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  JBRouterDelegate({
    required this.navigatorKey,
    required this.routes,
    required this.notFoundPageBuilder,
    required this.initialPath,
  });

  @override
  JBRouteInfo? get currentConfiguration => _configuration;
  JBRouteInfo? _configuration;

  final List<JBPageRoute> _history = [];

  @override
  Widget build(BuildContext context) {
    final pages = _getPages(context);

    return Navigator(
      key: navigatorKey,
      pages: [
        if (pages.isNotEmpty)
          ...pages
        else
          const MaterialPage(child: SizedBox()),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return _pop(route);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(JBRouteInfo configuration) async {
    _configuration = configuration;
    _history.add(_matchPage(configuration));
    notifyListeners();
    return SynchronousFuture(null);
  }

  List<Page> _getPages(BuildContext context) {
    return _history
        .map(
          (route) => MaterialPage(
            child: route.page(context),
            name: route.path,
          ),
        )
        .toList();
  }

  JBPageRoute _matchPage(JBRouteInfo routeInfo) {
    return routes.firstWhere(
      (route) => route.path == routeInfo.path,
      orElse: () => JBPageRoute(
        path: routeInfo.path,
        page: (context) => notFoundPageBuilder(context, routeInfo.path),
      ),
    );
  }

  bool _pop(Route route) {
    if (_history.length > 1) {
      _history.removeWhere(
        (pageRoute) => route.settings.name == pageRoute.path,
      );
      final topRoute = _history.last;
      _configuration = JBRouteInfo(path: topRoute.path);

      if (kIsWeb) {
        window.history.back();
      }

      notifyListeners();
      return true;
    }
    return false;
  }
}

class JBRouteParser extends RouteInformationParser<JBRouteInfo> {
  @override
  Future<JBRouteInfo> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final path = routeInformation.location ?? '';

    return JBRouteInfo(path: path);
  }

  @override
  RouteInformation? restoreRouteInformation(JBRouteInfo configuration) {
    return RouteInformation(
      location: configuration.path,
    );
  }
}
