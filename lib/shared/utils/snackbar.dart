import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

enum SnackBarType { success, error, warning }

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
  }) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
          content: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: AppTypography.style14W500.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                ),
                const Gap(8),
                _buildIcon(context, type),
              ],
            ),
          ),
        ),
      );
    }
  }

  static Widget _buildIcon(BuildContext context, SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 24,
        );
      case SnackBarType.error:
        return const Icon(
          Icons.error,
          color: Colors.red,
          size: 24,
        );
      case SnackBarType.warning:
        return const Icon(
          Icons.warning,
          color: Color(0xFFFFA600),
          size: 24,
        );
    }
  }
}

void fnShowSnackBarError(String text) {
  final context = navKey.currentContext;
  if (context != null) {
    AppSnackbar.show(
      context,
      message: text,
      type: SnackBarType.error,
    );
  }
}

void fnShowSnackBarSuccess(String text) {
  final context = navKey.currentContext;
  if (context != null) {
    AppSnackbar.show(
      context,
      message: text,
      type: SnackBarType.success,
    );
  }
}

void fnShowSnackBarWarning(String text) {
  final context = navKey.currentContext;
  if (context != null) {
    AppSnackbar.show(
      context,
      message: text,
      type: SnackBarType.warning,
    );
  }
}

