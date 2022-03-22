import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'nested_go_router.dart';

class GoRouterApp extends StatelessWidget {
  GoRouterApp({Key? key}) : super(key: key);

  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/list',
        pageBuilder: (context, state) => MaterialPage(
          child: const ListPage(),
          key: ValueKey('List'),
        ),
      ),
      GoRoute(
        path: '/list/:id',
        pageBuilder: (context, state) => MaterialPage(
          child: ListPage(
            nested: DetailsPage(id: state.params['id']!),
          ),
          key: const ValueKey('List'),
        ),
      ),
      GoRoute(
        path: '/list/:id/comments',
        pageBuilder: (context, state) => MaterialPage(
          child: ListPage(
            nested: DetailsPage(
              id: state.params['id']!,
              nested: const CommentsPage(),
            ),
          ),
          key: const ValueKey('List'),
        ),
      ),
      // ...NestedGoRoute(
      //   path: '/list',
      //   builder: (context, state, [nested]) => ListPage(nested: nested),
      //   nestedRoutes: [
      //     NestedGoRoute(
      //       path: '/:id',
      //       builder: (context, state, [nested]) => DetailsPage(
      //         id: state.params['id']!,
      //         nested: nested,
      //       ),
      //       nestedRoutes: [
      //         NestedGoRoute(
      //           path: '/comments',
      //           builder: (context, state, [nested]) => const CommentsPage(),
      //         )
      //       ],
      //       subroutes: [
      //         GoRoute(
      //           path: 'settings',
      //           builder: (context, state) => SettingsPage(),
      //         )
      //       ],
      //     )
      //   ],
      // ).goRoutes,
    ],
    debugLogDiagnostics: true,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({
    Key? key,
    this.nested,
  }) : super(key: key);

  final Widget? nested;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ListPage'),
          if (nested != null) nested!,
        ],
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
    required this.id,
    this.nested,
  }) : super(key: key);

  final String id;
  final Widget? nested;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Details: $id'),
        if (nested != null) nested!,
      ],
    );
  }
}

class CommentsPage extends StatelessWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Comments'),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SettingsPage'),
      ),
    );
  }
}
