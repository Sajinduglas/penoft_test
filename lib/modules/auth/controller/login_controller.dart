
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final String? phNumber; // not used now, but kept for compatibility
  LoginController({required this.phNumber});

  final RxBool showOtp = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();

  // email
  RxString email = RxString("");

  // otp
  RxnInt otp = RxnInt(null);

  // Request OTP
  Future<void> onEmailSubmit([bool? bypassValidation]) async {
    if ((bypassValidation ?? false) || formKey.currentState!.validate()) {
      // var otpRes = await LoginRepository.requestOtp(email.value);
      // otpRes.fold(
        // (left) => fnShowSnackBarError(left.message),
        // (right) => showOtp(true),
      // );
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
      // var res = await LoginRepository.login(otp.value!, email.value);
      // res.fold(
        // (left) => fnShowSnackBarError(left.message),
        // (right) => userController.onLoginIn(right),
      // );
    } else {
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
