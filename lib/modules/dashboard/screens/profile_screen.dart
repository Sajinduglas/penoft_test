import 'package:flutter/material.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTypography.style18W600.copyWith(
            color: AppColors.neutral900,
          ),
        ),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Profile Screen',
          style: AppTypography.style18W600.copyWith(
            color: AppColors.neutral900,
          ),
        ),
      ),
    );
  }
}

