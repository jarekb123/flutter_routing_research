import 'package:flutter/material.dart';
import 'package:router_experiments/auto_route_multiple/list/list_routes.gr.dart';

class ListRouterPage extends StatefulWidget {
  const ListRouterPage({Key? key}) : super(key: key);

  @override
  State<ListRouterPage> createState() => _ListRouterPageState();
}

class _ListRouterPageState extends State<ListRouterPage> {
  late ChildBackButtonDispatcher? _backButtonDispatcher;
  late ListRoutes _listRouter;

  @override
  void initState() {
    super.initState();
    _listRouter = ListRoutes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        ?.createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _listRouter.delegate(
        
      ),
      routeInformationParser: _listRouter.defaultRouteParser(),
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}
