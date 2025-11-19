import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/repo/auth_repository.dart';
import 'package:penoft_machine_test/modules/auth/screens/profile_complete/profile_complete.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';
import 'package:penoft_machine_test/shared/utils/snackbar.dart';

class SignUpController extends GetxController {
  final String? phNumber; // not used now, but kept for compatibility
  SignUpController({required this.phNumber});

  final RxBool showOtp = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();

  // Method to stop timer (called when navigating away from OTP screen)
  void stopTimer() {
    _resendTimer?.cancel();
    remainingSeconds.value = 0;
    canResend.value = false;
  }

  // email
  RxString email = RxString("");

  // otp
  RxnInt otp = RxnInt(null);

  // Timer for resend OTP
  Timer? _resendTimer;
  final RxInt remainingSeconds = 0.obs; // 6 minutes = 360 seconds
  final RxBool canResend = false.obs;

  static const int otpValiditySeconds = 360; // 6 minutes

  // Request OTP
  Future<void> onEmailSubmit([bool? bypassValidation]) async {
    if ((bypassValidation ?? false) || formKey.currentState!.validate()) {
      final trimmedEmail = email.value.trim();
      if (trimmedEmail.isEmpty) {
        fnShowSnackBarError('Email cannot be empty');
        return;
      }

      try {
        await AuthRepository.requestOtp(trimmedEmail);
        showOtp.value = true;
        fnShowSnackBarSuccess('OTP sent successfully');
        // Start the timer
        _startResendTimer();
      } on ApiException catch (e) {
        fnShowSnackBarError(e.message);
      } catch (e) {
        fnShowSnackBarError(e.toString());
      }
    }
  }

  // Resend OTP
  Future<void> resendOtp() async {
    if (!canResend.value) return;

    final trimmedEmail = email.value.trim();
    if (trimmedEmail.isEmpty) {
      fnShowSnackBarError('Email cannot be empty');
      return;
    }

    try {
      await AuthRepository.requestOtp(trimmedEmail);
      fnShowSnackBarSuccess('OTP sent successfully');
      // Restart the timer
      _startResendTimer();
    } on ApiException catch (e) {
      fnShowSnackBarError(e.message);
    } catch (e) {
      fnShowSnackBarError(e.toString());
    }
  }

  // Start resend timer
  void _startResendTimer() {
    _resendTimer?.cancel();
    remainingSeconds.value = otpValiditySeconds;
    canResend.value = false;

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        canResend.value = true;
      }
    });
  }

  // Format timer as MM:SS
  String get formattedTimer {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Format timer as "X minutes Y seconds" or "X second" (matching UI)
  String get formattedTimerText {
    if (remainingSeconds.value >= 60) {
      final minutes = remainingSeconds.value ~/ 60;
      final seconds = remainingSeconds.value % 60;
      if (seconds > 0) {
        return '$minutes min${minutes > 1 ? '' : ''}$seconds sec';
      } else {
        return '$minutes min${minutes > 1 ? '' : ''}';
      }
    } else {
      return '${remainingSeconds.value} sec';
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
        fnShowSnackBarError('Email cannot be empty');
        return;
      }

      try {
        final res = await AuthRepository.verifyOtp(
          email: trimmedEmail,
          otp: otp.value!.toString().padLeft(6, '0'),
        );
        await userController.onLoginIn(res.token, res.user);
        await appRouteState.setProfileComplete(false);
        
        // Stop the timer as OTP is verified
        stopTimer();
        
        // Show success snackbar
        fnShowSnackBarSuccess('OTP verified successfully');
        
        // Wait a bit before navigation to ensure snackbar is shown
        await Future.delayed(const Duration(milliseconds: 500));
        
        router.go('/${ProfileCompletePage.routeName}');
      } on ApiException catch (e) {
        fnShowSnackBarError(e.message);
      } catch (e) {
        fnShowSnackBarError(e.toString());
      }
    } else {
      fnShowSnackBarError('Enter a valid 6 digit OTP');
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

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }
}
