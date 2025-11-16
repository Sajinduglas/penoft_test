import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class Dashboard extends StatelessWidget {
  static const routeName = 'dashboard';

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: AppTypography.style18W600.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              appRouteState.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Dashboard',
                style: AppTypography.style18W600.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              if (userController.user.value.email != null)
                Text(
                  'Email: ${userController.user.value.email}',
                  style: AppTypography.style14W400.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

