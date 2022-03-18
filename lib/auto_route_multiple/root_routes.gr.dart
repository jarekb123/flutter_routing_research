// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'list/list_router_page.dart' as _i2;
import 'start_page.dart' as _i1;

class RootRouter extends _i3.RootStackRouter {
  RootRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    StartPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.StartPage());
    },
    ListRouterPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ListRouterPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(StartPageRoute.name, path: '/'),
        _i3.RouteConfig(ListRouterPageRoute.name, path: '/list')
      ];
}

/// generated route for
/// [_i1.StartPage]
class StartPageRoute extends _i3.PageRouteInfo<void> {
  const StartPageRoute() : super(StartPageRoute.name, path: '/');

  static const String name = 'StartPageRoute';
}

/// generated route for
/// [_i2.ListRouterPage]
class ListRouterPageRoute extends _i3.PageRouteInfo<void> {
  const ListRouterPageRoute() : super(ListRouterPageRoute.name, path: '/list');

  static const String name = 'ListRouterPageRoute';
}
