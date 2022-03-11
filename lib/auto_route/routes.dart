import 'package:auto_route/auto_route.dart';
import 'package:router_experiments/auto_route/auth/auth_service.dart';
import 'package:router_experiments/auto_route/auth/login_page.dart';
import 'package:router_experiments/auto_route/details_page.dart';
import 'package:router_experiments/auto_route/list_page.dart';
import 'package:router_experiments/auto_route/routes.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(
      initial: true,
      page: EmptyRouterPage,
      path: '/list',
      children: [
        AutoRoute(
          path: '',
          page: ListPage,
        ),
        AutoRoute(
          path: ':index',
          page: DetailsPage,
          children: [
            AutoRoute(page: CommentsPage, path: 'comments'),
          ],
        ),
      ],
    ),
    AutoRoute(
      page: LoginPage,
      path: '/login',
    )
  ],
  replaceInRouteName: 'Page',
)
class $AppRouter {}
