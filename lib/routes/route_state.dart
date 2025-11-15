import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/config/local_db.dart';
import 'package:penoft_machine_test/modules/auth/screens/login/login.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/routes.dart';

final AppRouterState appRouteState = AppRouterState();

class AppRouterState extends ChangeNotifier {
  AppRouterState() {
    _init();
  }

  void _init() async {
    final token = await LocalDb.getSavedToken();
    if (token != null && token.isNotEmpty) {
      _appStatus = AppStatus.authenticated;
      userController.initial();
    } else {
      _appStatus = AppStatus.unAuthenticated;
    }
    notifyListeners();
  }

  AppStatus _appStatus = AppStatus.unAuthenticated;
  AppStatus get appStatus => _appStatus;
  bool get isUserLoggedIn => _appStatus == AppStatus.authenticated;

  void onLogin() {
    _appStatus = AppStatus.authenticated;
    notifyListeners();
  }

  void logout() async {
    await LocalDb.clearAll();
    _appStatus = AppStatus.unAuthenticated;
    notifyListeners();
  }

  String? redirect(BuildContext context, GoRouterState state) {
    // Allow splash screen to show
    if (state.fullPath == "/splashScreen") {
      return null;
    }

    if (_appStatus == AppStatus.unAuthenticated) {
      if (!unAuthenticatedRoutes.contains(state.fullPath)) {
        return "/${LoginPage.routeName}";
      }
    } else {
      if (unAuthenticatedRoutes.contains(state.fullPath)) {
        return "/${Dashboard.routeName}";
      }
    }

    return null;
  }
}

enum AppStatus {
  authenticated,
  initial,
  unAuthenticated,
  network,
}
