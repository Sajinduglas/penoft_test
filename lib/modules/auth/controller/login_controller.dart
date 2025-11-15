import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final String? phNumber;
  LoginController({required this.phNumber});
  final RxBool showOtp = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();
  RxString gmail = RxString("");
  RxnInt otp = RxnInt(null);
  Future<void> onMobileNumberSubmit([bool? bypassValidation]) async {
    if ((bypassValidation ?? false) || formKey.currentState!.validate()) {
      var otpRes = await LoginRepository.requestOtp(gmail.value);
      otpRes.fold(
        (left) {
          fnShowSnackBarError(left.message);
        },
        (right) {
          showOtp(true);
        },
      );
    }
  }

  Future<void> btnSubmit() async {
    if (showOtp.value) {
      await logIn();
    } else {
      await onMobileNumberSubmit();
    }
  }

  Future<void> logIn() async {
    if (otp.value != null && otp.value!.numberOfDigit == 6) {
      var res = await LoginRepository.login(otp.value!, gmail.value);
      res.fold(
        (left) {
          fnShowSnackBarError(left.message);
        },
        (right) {
          userController.onLoginIn(right);
        },
      );
    } else {
      print(otp.value);
    }
  }

  @override
  void onInit() {
    if (phNumber != null) {
      print(phNumber);
      gmail.value = phNumber!;
      onMobileNumberSubmit(true);
    }
    super.onInit();
  }
}