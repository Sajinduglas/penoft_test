import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  // AppStatus _appStatus = AppStatus.initial;
  AppStatus _appStatus = AppStatus.unAuthenticated;
  AppStatus get appStatus => _appStatus;
  bool get isUserLoggedIn => _appStatus == AppStatus.authenticated;

  void onLogin() {
    print("after login enter into route state");
    _appStatus = AppStatus.authenticated;
    print("app ststsus$_appStatus");
    notifyListeners();
  }

  void logout() async {
    // await LocalDb.clearAll();
    _appStatus = AppStatus.unAuthenticated;
    notifyListeners();
  }

  String? redirect(BuildContext context, GoRouterState state) {
    print("intial Print $_appStatus");
    print(state.fullPath);
    // if (_appStatus == AppStatus.initial) {
    //   return null; // wait until init finishes
    // }
    if (_appStatus == AppStatus.unAuthenticated) {
      print("unnnnnnnnnnnauthenticateddddddddddddddddd");
      print("full path in unauthenticateddddddd${state.fullPath}");
      if (!unAuthenticatedRoutes.contains(state.fullPath)) {
        print("enter into elseeeeee");
        return "/${LoginScreen.routeName}";
      }
    } else {
      print("authenticateddddddddddddddddd");
      print("full path in authenticateddddddd${state.fullPath}");
      if (unAuthenticatedRoutes.contains(state.fullPath)) {
        return "/${VipDashboard.routeName}";
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
