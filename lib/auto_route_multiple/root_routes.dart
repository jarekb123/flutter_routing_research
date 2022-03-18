import 'package:auto_route/auto_route.dart';
import 'package:router_experiments/auto_route_multiple/list/list_router_page.dart';
import 'package:router_experiments/auto_route_multiple/start_page.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(path: '/', page: StartPage),
  AutoRoute(path: '/list', page: ListRouterPage),
])
class $RootRouter {}
