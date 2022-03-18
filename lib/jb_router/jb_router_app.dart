import 'package:flutter/material.dart';
import 'package:router_experiments/jb_router/jb_router.dart';

class JBRouterApp extends StatefulWidget {
  const JBRouterApp({Key? key}) : super(key: key);

  @override
  State<JBRouterApp> createState() => _JBRouterAppState();
}

class _JBRouterAppState extends State<JBRouterApp> {
  late GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: JBRouteParser(),
      routerDelegate: JBRouterDelegate(
        navigatorKey: navigatorKey,
        initialPath: '/',
        routes: [
          JBPageRoute(
            path: '/',
            page: (context) => const HomePage(),
          ),
          JBPageRoute(
            path: '/list',
            page: (context) => const ListPage(),
          ),
        ],
        notFoundPageBuilder: (context, path) => NotFoundPage(path: path),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Back To Home'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Not found: $path'),
      ),
    );
  }
}
