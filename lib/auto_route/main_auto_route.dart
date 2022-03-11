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

  @override
  void initState() {
    super.initState();
    authService = AuthService();
    appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>.value(
      value: authService,
      child: StreamBuilder<bool>(
        stream: authService.authState,
        initialData: authService.isAuthenticated(),
        builder: (context, snapshot) {
          final authenticated = snapshot.data ?? false;

          return MaterialApp(
            builder: (context, child) {
              if (!authenticated) {
                return LoginPage(onSuccess: () {});
              } else {
                return Router(
                  routerDelegate: appRouter.delegate(),
                  routeInformationParser: appRouter.defaultRouteParser(),
                  routeInformationProvider: appRouter.routeInfoProvider(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
