import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/repo/auth_repository.dart';
import 'package:penoft_machine_test/modules/auth/screens/profile_complete/profile_complete.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';

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
      final trimmedEmail = email.value.trim();
      if (trimmedEmail.isEmpty) {
        Get.snackbar(
          'Validation',
          'Email cannot be empty',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      try {
        await AuthRepository.requestOtp(trimmedEmail);
        showOtp.value = true;
        Get.snackbar(
          'Success',
          'OTP sent successfully to $trimmedEmail',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } on ApiException catch (e) {
        Get.snackbar(
          'OTP Request Failed',
          e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
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
        final res = await AuthRepository.verifyOtp(
          email: trimmedEmail,
          otp: otp.value!.toString().padLeft(6, '0'),
        );
        await userController.onLoginIn(res.token, res.user);
        await appRouteState.setProfileComplete(false);

        Get.snackbar(
          'Success',
          'OTP verified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        router.go('/${ProfileCompletePage.routeName}');
      } on ApiException catch (e) {
        Get.snackbar(
          'OTP Verification Failed',
          e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } else {
      Get.snackbar(
        'Invalid OTP',
        'Enter a valid 6 digit OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
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
