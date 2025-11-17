import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/repo/auth_repository.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';

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
        Get.snackbar(
          'Validation',
          'Email cannot be empty',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      try {
        final res = await AuthRepository.generateToken(trimmedEmail);
        await userController.onLoginIn(res.token, res.user);
        // For login, set profile complete to true (existing users don't need profile complete)
        await appRouteState.setProfileComplete(true);

        // Navigate to dashboard
        router.go('/${Dashboard.routeName}');
      } on ApiException catch (e) {
        Get.snackbar(
          'Login failed',
          e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
