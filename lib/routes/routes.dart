import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/screens/login/login.dart';
import 'package:penoft_machine_test/modules/auth/screens/profile_complete/profile_complete.dart';
import 'package:penoft_machine_test/modules/auth/screens/splash/splash.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/main_navigation_screen.dart';
import 'package:penoft_machine_test/routes/route_state.dart';

GlobalKey<NavigatorState> navKey = GlobalKey();
GoRouter router = GoRouter(
    initialLocation: "/${PenoftSplash.routeName}",
    navigatorKey: navKey,
    routes: [
      GoRoute(
        path: "/${PenoftSplash.routeName}",
        name: PenoftSplash.routeName,
        builder: (context, state) {
          return const PenoftSplash();
        },
      ),
      GoRoute(
        path: "/${LoginPage.routeName}",
        name: LoginPage.routeName,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: "/${ProfileCompletePage.routeName}",
        name: ProfileCompletePage.routeName,
        builder: (context, state) {
          return const ProfileCompletePage();
        },
      ),
      GoRoute(
        path: "/${Dashboard.routeName}",
        name: Dashboard.routeName,
        builder: (context, state) {
          return const MainNavigationScreen();
        },
      ),
    ],
    refreshListenable: appRouteState,
    redirect: appRouteState.redirect);

List<String> unAuthenticatedRoutes = [
  "/${PenoftSplash.routeName}",
  "/${LoginPage.routeName}",
  "/${ProfileCompletePage.routeName}",
];
