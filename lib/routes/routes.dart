import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/screens/splash/splash.dart';
import 'package:penoft_machine_test/routes/route_state.dart';


GlobalKey<NavigatorState> navKey = GlobalKey();
GoRouter router = GoRouter(
    initialLocation: "/${PenoftSplash.routeName}",
    navigatorKey: navKey,
    routes: [
      GoRoute(
          path: "/${LoginScreen.routeName}",
          name: LoginScreen.routeName,
          builder: (context, state) {
            return LoginScreen();
          }),
      
    ],
    refreshListenable: appRouteState,
    redirect: appRouteState.redirect);

List<String> unAuthenticatedRoutes = [
  "/${LoginScreen.routeName}",
];
