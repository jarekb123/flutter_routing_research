import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:router_experiments/auto_route/auth/auth_service.dart';
import 'package:router_experiments/auto_route/auth/login_page.dart';
import 'package:router_experiments/auto_route/routes.dart';
import 'package:router_experiments/auto_route/routes.gr.dart';

class AutoRouteApp extends StatefulWidget {
  const AutoRouteApp({Key? key}) : super(key: key);

  @override
  State<AutoRouteApp> createState() => _AutoRouteAppState();
}

class _AutoRouteAppState extends State<AutoRouteApp> {
  late AppRouter appRouter;
  late AuthService authService;
  late TextEditingController controller = TextEditingController();
  late RouteInformationProvider routeInformationProvider;
  late RouterDelegate delegate;
  late RouteInformationParser parser;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
    appRouter = AppRouter(
        // authGuard: AuthGuard(authService),
        );
    routeInformationProvider = SimpleRouteInformationProviderWrapper(
      LoggingRouteInformationProvider(
        appRouter.routeInfoProvider(),
      ),
      onRouteChanged: (routeInformation, type) {
        controller.text = routeInformation.location ?? '/';
      },
    );
    delegate = appRouter.delegate();
    parser = appRouter.defaultRouteParser();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>.value(
      value: authService,
      child: MaterialApp(
        builder: (context, child) {
          return Column(
            children: [
              UrlPathTextField(
                controller: controller,
                routeInformationProvider: routeInformationProvider,
                routeInformationParser: parser,
                routerDelegate: delegate,
              ),
              Expanded(
                child: Router(
                  routerDelegate: delegate,
                  routeInformationParser: parser,
                  routeInformationProvider: routeInformationProvider,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class UrlPathTextField extends StatelessWidget {
  const UrlPathTextField({
    Key? key,
    required this.controller,
    required this.routeInformationProvider,
    required this.routeInformationParser,
    required this.routerDelegate,
  }) : super(key: key);

  final TextEditingController controller;
  final RouteInformationProvider routeInformationProvider;
  final RouteInformationParser routeInformationParser;
  final RouterDelegate routerDelegate;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          onEditingComplete: () async {
            var routeInformation = RouteInformation(location: controller.text);
            routeInformationProvider.routerReportsNewRouteInformation(
              routeInformation,
              type: RouteInformationReportingType.none,
            );
            routerDelegate.setNewRoutePath(
              await routeInformationParser
                  .parseRouteInformation(routeInformation),
            );
          },
        ),
      ),
    );
  }
}

mixin RouteInformationProviderWrapper on RouteInformationProvider {
  RouteInformationProvider get parent;

  @override
  void addListener(VoidCallback listener) => parent.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => parent.removeListener(listener);

  @override
  RouteInformation get value => parent.value;

  @override
  void routerReportsNewRouteInformation(
    RouteInformation routeInformation, {
    required RouteInformationReportingType type,
  }) {
    parent.routerReportsNewRouteInformation(routeInformation, type: type);
    onRouterReportsNewRouteInformation(routeInformation, type: type);
  }

  void onRouterReportsNewRouteInformation(
    RouteInformation routeInformation, {
    required RouteInformationReportingType type,
  });
}

class SimpleRouteInformationProviderWrapper extends RouteInformationProvider
    with RouteInformationProviderWrapper {
  @override
  final RouteInformationProvider parent;

  final void Function(
    RouteInformation routeInformation,
    RouteInformationReportingType type,
  ) onRouteChanged;

  SimpleRouteInformationProviderWrapper(
    this.parent, {
    required this.onRouteChanged,
  });

  @override
  void onRouterReportsNewRouteInformation(
    RouteInformation routeInformation, {
    required RouteInformationReportingType type,
  }) =>
      onRouteChanged(routeInformation, type);
}

class LoggingRouteInformationProvider extends RouteInformationProvider
    with RouteInformationProviderWrapper {
  @override
  final RouteInformationProvider parent;

  LoggingRouteInformationProvider(this.parent);

  @override
  void onRouterReportsNewRouteInformation(
    RouteInformation routeInformation, {
    required RouteInformationReportingType type,
  }) {
    print('Route Location: ${routeInformation.location}');
    print('Route Reporting Type: ${type.name}');
  }
}
