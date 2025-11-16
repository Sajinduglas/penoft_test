import 'package:flutter/material.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';

class AppDecoration {
  static InputDecoration fieldDecoration(
    BuildContext context,
  ) {
    return InputDecoration(
      filled: true,
      fillColor: AppColors.backgroundWhite,
      hintStyle: const TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.neutral900),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.borderLight),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }
}