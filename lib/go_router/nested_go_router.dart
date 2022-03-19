import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef NestedRouterBuilder = Widget Function(
  BuildContext context,
  GoRouterState state, [
  Widget? nested,
]);

class NestedGoRoute {
  final String path;

  final NestedRouterBuilder builder;

  final List<NestedGoRoute> nestedRoutes;
  final List<GoRoute> subroutes;

  NestedGoRoute({
    required this.path,
    required this.builder,
    this.nestedRoutes = const [],
    this.subroutes = const [],
  });

  List<GoRoute> get goRoutes {
    var createNestedGoRoutes = _createNestedGoRoutes(
      key: ValueKey(path),
      nestedGoRoute: this,
    );
    return createNestedGoRoutes.toList();
  }
}

Iterable<GoRoute> _createNestedGoRoutes({
  required LocalKey key,
  required NestedGoRoute nestedGoRoute,
  String parentPath = '',
  NestedRouterBuilder? parentBuilder,
}) {
  if (parentBuilder == null) {
    return [
      GoRoute(
        path: parentPath + nestedGoRoute.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: key,
            child: nestedGoRoute.builder(context, state),
          );
        },
        routes: nestedGoRoute.subroutes,
      ),
      ...nestedGoRoute.nestedRoutes.expand(
        (route) {
          return _createNestedGoRoutes(
            key: key,
            nestedGoRoute: route,
            parentPath: parentPath + nestedGoRoute.path,
            parentBuilder: (context, state, [nested]) {
              return nestedGoRoute.builder(
                context,
                state,
                route.builder(context, state, nested),
              );
            },
          );
        },
      ),
    ];
  } else {
    return [
      GoRoute(
        path: parentPath + nestedGoRoute.path,
        pageBuilder: (context, state) {
          return MaterialPage(
            key: key,
            child: parentBuilder(context, state),
          );
        },
        routes: nestedGoRoute.subroutes,
      ),
      ...nestedGoRoute.nestedRoutes.expand((route) {
        return _createNestedGoRoutes(
          key: key,
          parentPath: parentPath + nestedGoRoute.path,
          nestedGoRoute: route,
          parentBuilder: (context, state, [nested]) {
            return parentBuilder(
              context,
              state,
              route.builder(context, state, nested),
            );
          },
        );
      }),
    ];
  }
}
