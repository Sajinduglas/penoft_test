import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';

class LoginController extends GetxController {
  LoginController();

  final RxBool rememberMe = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();

  // email
  RxString email = RxString("");

  // Login directly with email
  Future<void> btnSubmit() async {
    if (formKey.currentState!.validate()) {
      // TODO: When API is ready, uncomment and implement:
      // var res = await LoginRepository.login(email.value);
      // res.fold(
      //   (left) => fnShowSnackBarError(left.message),
      //   (right) {
      //     userController.onLoginIn(right.accessToken!, right.user ?? User());
      //     appRouteState.onLogin();
      //     Get.context!.go('/${Dashboard.routeName}');
      //   },
      // );

      // For now, mock login success
      final mockToken = "mock_token_${DateTime.now().millisecondsSinceEpoch}";
      final mockUser = User(
        id: "1",
        name: "User",
        email: email.value,
      );

      await userController.onLoginIn(mockToken, mockUser);
      // For login, set profile complete to true (existing users don't need profile complete)
      await appRouteState.setProfileComplete(true);

      // Navigate to dashboard
      router.go('/${Dashboard.routeName}');
    }
  }
}


