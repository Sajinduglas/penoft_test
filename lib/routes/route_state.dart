import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/config/local_db.dart';
import 'package:penoft_machine_test/modules/auth/screens/login/login.dart';
import 'package:penoft_machine_test/modules/auth/screens/profile_complete/profile_complete.dart';
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
    // if (token != null && token.isNotEmpty) {
    if (token == null ) {
      _appStatus = AppStatus.authenticated;
      _isProfileComplete = await LocalDb.isProfileComplete();
      // _isProfileComplete =  true;
      userController.initial();
    } else {
      _appStatus = AppStatus.unAuthenticated;
      _isProfileComplete = false;
    }
    notifyListeners();
  }

  AppStatus _appStatus = AppStatus.unAuthenticated;
  bool _isProfileComplete = false;
  
  AppStatus get appStatus => _appStatus;
  bool get isUserLoggedIn => _appStatus == AppStatus.authenticated;
  bool get isProfileComplete => _isProfileComplete;

  void onLogin() {
    _appStatus = AppStatus.authenticated;
    notifyListeners();
  }

  Future<void> setProfileComplete(bool isComplete) async {
    _isProfileComplete = isComplete;
    await LocalDb.setProfileComplete(isComplete);
    notifyListeners();
  }

  void logout() async {
    await LocalDb.clearAll();
    _appStatus = AppStatus.unAuthenticated;
    _isProfileComplete = false;
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
      // User is authenticated
      // Check if profile is complete
      if (!_isProfileComplete) {
        // Profile not complete - redirect to profile complete screen
        if (state.fullPath != "/${ProfileCompletePage.routeName}") {
          return "/${ProfileCompletePage.routeName}";
        }
      } else {
        // Profile is complete
        if (unAuthenticatedRoutes.contains(state.fullPath)) {
          return "/${Dashboard.routeName}";
        }
        // If trying to access profile complete when already complete, go to dashboard
        if (state.fullPath == "/${ProfileCompletePage.routeName}") {
          return "/${Dashboard.routeName}";
        }
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
