import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/repo/auth_repository.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';
import 'package:penoft_machine_test/shared/utils/snackbar.dart';

class LoginController extends GetxController {
  LoginController();

  final RxBool rememberMe = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();

  // email
  RxString email = RxString("");

  // Login directly with email
  Future<void> btnSubmit() async {
    if (formKey.currentState!.validate()) {
      final trimmedEmail = email.value.trim();
      if (trimmedEmail.isEmpty) {
        fnShowSnackBarError('Email cannot be empty');
        return;
      }

      try {
        final res = await AuthRepository.generateToken(trimmedEmail);
        await userController.onLoginIn(res.token, res.user);
        // For login, set profile complete to true (existing users don't need profile complete)
        await appRouteState.setProfileComplete(true);

        // Show success snackbar
        fnShowSnackBarSuccess('Login successful');

        // Wait a bit before navigation to ensure snackbar is shown
        await Future.delayed(const Duration(milliseconds: 500));

        // Navigate to dashboard
        router.go('/${Dashboard.routeName}');
      } on ApiException catch (e) {
        fnShowSnackBarError(e.message);
      } catch (e) {
        fnShowSnackBarError(e.toString());
      }
    }
  }
}
