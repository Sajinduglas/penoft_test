import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/config/local_db.dart';
import 'package:penoft_machine_test/modules/auth/screens/google_profile_complete/google_profile_complete.dart';
import 'package:penoft_machine_test/modules/auth/screens/login/login.dart';
import 'package:penoft_machine_test/modules/auth/screens/signup/sign_up.dart';
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
    if (token != null && token.isNotEmpty) {
      _appStatus = AppStatus.authenticated;
      _isProfileComplete = await LocalDb.isProfileComplete();
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
    // Note: _isProfileComplete should be set separately
    // For login: set to true (existing users)
    // For signup: keep false until profile is completed
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
      // Allow access to ProfileCompletePage only if profile is not complete
      if (state.fullPath == "/${ProfileCompletePage.routeName}") {
        if (_isProfileComplete) {
          // Profile already complete, redirect to dashboard
          return "/${Dashboard.routeName}";
        }
        return null; // Allow access to profile complete
      }
      // Allow access to GoogleProfileCompleteScreen (for Google sign in flow)
      if (state.fullPath == "/${GoogleProfileCompleteScreen.routeName}") {
        return null; // Allow access
      }
      // Redirect other unauthenticated routes to dashboard
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
