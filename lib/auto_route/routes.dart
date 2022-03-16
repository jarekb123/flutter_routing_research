import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:router_experiments/auto_route/auth/auth_service.dart';
import 'package:router_experiments/auto_route/auth/login_page.dart';
import 'package:router_experiments/auto_route/details_page.dart';
import 'package:router_experiments/auto_route/empty_page.dart';
import 'package:router_experiments/auto_route/list_page.dart';
import 'package:router_experiments/auto_route/routes.gr.dart';

@AdaptiveAutoRouter(
  routes: [
    AutoRoute(
      initial: true,
      page: ListPageWithDetails,
      path: '/list',
      children: [
        AutoRoute(
          path: ':index',
          page: DetailsPage,
          // guards: [AuthGuard],
          children: [
            AutoRoute(page: CommentsPage, path: 'comments', initial: true),
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

class AuthGuard extends AutoRouteGuard {
  final AuthService _authService;

  AuthGuard(this._authService);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authService.isAuthenticated()) {
      resolver.next();
    } else {
      router.push(
        LoginPageRoute(
          onSuccess: () => resolver.next(),
        ),
      );
    }
  }
}
