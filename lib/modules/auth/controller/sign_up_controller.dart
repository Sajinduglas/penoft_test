import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/screens/profile_complete/profile_complete.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';

class SignUpController extends GetxController {
  final String? phNumber; // not used now, but kept for compatibility
  SignUpController({required this.phNumber});

  final RxBool showOtp = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();

  // email
  RxString email = RxString("");

  // otp
  RxnInt otp = RxnInt(null);

  // Request OTP
  Future<void> onEmailSubmit([bool? bypassValidation]) async {
    if ((bypassValidation ?? false) || formKey.currentState!.validate()) {
      // TODO: When API is ready, uncomment and implement:
      // var otpRes = await LoginRepository.requestOtp(email.value);
      // otpRes.fold(
      //   (left) => fnShowSnackBarError(left.message),
      //   (right) => showOtp(true),
      // );

      // For now, just show OTP screen
      showOtp.value = true;
    }
  }

  // Main button
  Future<void> btnSubmit() async {
    if (showOtp.value) {
      await verifyOtpLogin();
    } else {
      await onEmailSubmit();
    }
  }

  // Verify OTP + Login
  Future<void> verifyOtpLogin() async {
    if (otp.value != null && otp.value.toString().length == 6) {
      // TODO: When API is ready, uncomment and implement:
      // var res = await LoginRepository.login(otp.value!, email.value);
      // res.fold(
      //   (left) => fnShowSnackBarError(left.message),
      //   (right) {
      //     userController.onLoginIn(right.accessToken!, right.user ?? User());
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
      // Note: onLogin() is already called in userController.onLoginIn()
      // Profile complete stays false until user completes profile

      // Navigate to profile complete screen
      router.go('/${ProfileCompletePage.routeName}');
    } else {
      // TODO: Show error message
      // fnShowSnackBarError("Enter valid 6 digit OTP");
    }
  }

  @override
  void onInit() {
    if (phNumber != null) {
      email.value = phNumber!; // reuse initial value
      onEmailSubmit(true);
    }
    super.onInit();
  }
}
