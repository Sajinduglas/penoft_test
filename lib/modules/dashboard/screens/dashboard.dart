import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class Dashboard extends StatelessWidget {
  static const routeName = 'dashboard';

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: AppTypography.style18W600.copyWith(
            color: const Color(0xFF0F172A),
          ),
        ),
        backgroundColor: Colors.white,
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
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 16),
              if (userController.user.value.email != null)
                Text(
                  'Email: ${userController.user.value.email}',
                  style: AppTypography.style14W400.copyWith(
                    color: const Color(0xFF64748B),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

