// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:router_experiments/auto_route/auth/login_page.dart' as _i2;
import 'package:router_experiments/auto_route/details_page.dart' as _i3;
import 'package:router_experiments/auto_route/list_page.dart' as _i1;
import 'package:router_experiments/auto_route/routes.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter(
      {_i5.GlobalKey<_i5.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i6.AuthGuard authGuard;

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ListPageWithDetailsRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ListPageWithDetails());
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>();
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.LoginPage(key: args.key, onSuccess: args.onSuccess));
    },
    DetailsPageRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DetailsPageRouteArgs>(
          orElse: () =>
              DetailsPageRouteArgs(index: pathParams.getInt('index')));
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.DetailsPage(key: args.key, index: args.index));
    },
    CommentsPageRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.CommentsPage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/list', fullMatch: true),
        _i4.RouteConfig(ListPageWithDetailsRoute.name, path: '/list', guards: [
          authGuard
        ], children: [
          _i4.RouteConfig(DetailsPageRoute.name,
              path: ':index',
              parent: ListPageWithDetailsRoute.name,
              children: [
                _i4.RouteConfig(CommentsPageRoute.name,
                    path: 'comments', parent: DetailsPageRoute.name)
              ])
        ]),
        _i4.RouteConfig(LoginPageRoute.name, path: '/login')
      ];
}

/// generated route for
/// [_i1.ListPageWithDetails]
class ListPageWithDetailsRoute extends _i4.PageRouteInfo<void> {
  const ListPageWithDetailsRoute({List<_i4.PageRouteInfo>? children})
      : super(ListPageWithDetailsRoute.name,
            path: '/list', initialChildren: children);

  static const String name = 'ListPageWithDetailsRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginPageRoute extends _i4.PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({_i5.Key? key, required void Function() onSuccess})
      : super(LoginPageRoute.name,
            path: '/login',
            args: LoginPageRouteArgs(key: key, onSuccess: onSuccess));

  static const String name = 'LoginPageRoute';
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({this.key, required this.onSuccess});

  final _i5.Key? key;

  final void Function() onSuccess;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, onSuccess: $onSuccess}';
  }
}

/// generated route for
/// [_i3.DetailsPage]
class DetailsPageRoute extends _i4.PageRouteInfo<DetailsPageRouteArgs> {
  DetailsPageRoute(
      {_i5.Key? key, required int index, List<_i4.PageRouteInfo>? children})
      : super(DetailsPageRoute.name,
            path: ':index',
            args: DetailsPageRouteArgs(key: key, index: index),
            rawPathParams: {'index': index},
            initialChildren: children);

  static const String name = 'DetailsPageRoute';
}

class DetailsPageRouteArgs {
  const DetailsPageRouteArgs({this.key, required this.index});

  final _i5.Key? key;

  final int index;

  @override
  String toString() {
    return 'DetailsPageRouteArgs{key: $key, index: $index}';
  }
}

/// generated route for
/// [_i3.CommentsPage]
class CommentsPageRoute extends _i4.PageRouteInfo<void> {
  const CommentsPageRoute() : super(CommentsPageRoute.name, path: 'comments');

  static const String name = 'CommentsPageRoute';
}
