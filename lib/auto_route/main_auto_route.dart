import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:router_experiments/auto_route/auth/auth_service.dart';
import 'package:router_experiments/auto_route/routes.dart';
import 'package:router_experiments/auto_route/routes.gr.dart';
import 'package:router_experiments/url_widget/url_widget.dart';

class AutoRouteApp extends StatefulWidget {
  const AutoRouteApp({Key? key}) : super(key: key);

  @override
  State<AutoRouteApp> createState() => _AutoRouteAppState();
}

class _AutoRouteAppState extends State<AutoRouteApp> {
  late AppRouter appRouter;
  late AuthService authService;
  late TextEditingController controller = TextEditingController();
  late RouterDelegate delegate;
  late RouteInformationParser parser;

  @override
  void initState() {
    super.initState();
    authService = AuthService();
    appRouter = AppRouter(
      authGuard: AuthGuard(authService),
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
              UrlWidget(
                routerDelegate: delegate,
                routeInformationParser: parser,
              ),
              Expanded(
                child: Router(
                  routerDelegate: delegate,
                  routeInformationParser: parser,
                  routeInformationProvider: appRouter.routeInfoProvider(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
