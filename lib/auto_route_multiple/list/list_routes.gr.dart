// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import 'details_page.dart' as _i1;

class ListRoutes extends _i2.RootStackRouter {
  ListRoutes([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    DetailsPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailsPageRouteArgs>(
          orElse: () => DetailsPageRouteArgs(id: pathParams.getInt('id')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.DetailsPage(key: args.key, id: args.id));
    }
  };

  @override
  List<_i2.RouteConfig> get routes =>
      [_i2.RouteConfig(DetailsPageRoute.name, path: '/:id')];
}

/// generated route for
/// [_i1.DetailsPage]
class DetailsPageRoute extends _i2.PageRouteInfo<DetailsPageRouteArgs> {
  DetailsPageRoute({_i3.Key? key, required int id})
      : super(DetailsPageRoute.name,
            path: '/:id',
            args: DetailsPageRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'DetailsPageRoute';
}

class DetailsPageRouteArgs {
  const DetailsPageRouteArgs({this.key, required this.id});

  final _i3.Key? key;

  final int id;

  @override
  String toString() {
    return 'DetailsPageRouteArgs{key: $key, id: $id}';
  }
}
