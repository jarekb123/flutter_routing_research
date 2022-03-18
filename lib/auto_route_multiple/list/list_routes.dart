import 'package:auto_route/annotations.dart';
import 'package:router_experiments/auto_route_multiple/list/details_page.dart';

@MaterialAutoRouter(routes: [
  AutoRoute(
    path: '/:id',
    page: DetailsPage,
  )
])
class $ListRoutes {}
