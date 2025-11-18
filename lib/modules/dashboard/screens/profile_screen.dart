import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/dashboard/controller/profile_controller.dart';
import 'package:penoft_machine_test/modules/dashboard/widgets/circle_icon.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';
import 'package:penoft_machine_test/shared/utils/tag_generator.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/inputform.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController controller;
  final String tag = tagGenerator();

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController(), tag: tag);
  }

  @override
  void dispose() {
    Get.delete<ProfileController>(tag: tag);
    super.dispose();
  }

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
        actions: [
            
            CircleIconButton(
              size: 40,
              borderColor: AppColors.neutral300,
              backgroundColor: AppColors.backgroundWhite,
              child: const Icon(Icons.logout,
                  size: 14, color: AppColors.neutral900),
              onPressed: () {
                _showLogoutDialog(context);
              },
            ),
             const SizedBox(width: 8),
          ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.error.value != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          controller.error.value!,
                          style: AppTypography.style14W400.copyWith(
                            color: AppColors.neutral600,
                          ),
                        ),
                        const Gap(16),
                        ElevatedButton(
                          onPressed: () => controller.loadUserData(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(40),
                          // Title
                          Text(
                            "Your Profile",
                            style: AppTypography.style18W600.copyWith(
                              color: AppColors.neutral900,
                            ),
                          ),
                          // const Gap(12),
                          // Text(
                          //   "If needed you can change the details by clicking on them",
                          //   style: AppTypography.style14W400.copyWith(
                          //     color: AppColors.neutral600,
                          //   ),
                          // ),
                          const Gap(40),

                          // Profile Picture
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                  child: controller.user.picture != null &&
                                          controller.user.picture!.isNotEmpty
                                      ? ClipOval(
                                          child: Image.network(
                                            controller.user.picture!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(
                                                Icons.person,
                                                size: 60,
                                                color: AppColors.neutral500,
                                              );
                                            },
                                          ),
                                        )
                                      : Icon(
                                          Icons.person,
                                          size: 60,
                                          color: AppColors.neutral500,
                                        ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(40),

                          // Full Name Input (Read-only display)
                          InputForm(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            initialValue: controller.user.name ?? '',
                            label: "Full name",
                            hintText: "Enter your full name",
                            enabled: false,
                          ),

                          const Gap(20),

                          // Email Input (Read-only display)
                          InputForm(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            initialValue: controller.user.email ?? '',
                            label: "Mail Id",
                            hintText: "Enter your email",
                            prefixIcon: Assets.svg.mail
                                .icon(context, color: AppColors.neutral500)
                                .square(12),
                            enabled: false,
                          ),

                          const Gap(20),

                          // Phone Number Input (Read-only display)
                          InputForm(
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            initialValue: controller.user.phone ?? '',
                            label: "Phone Number",
                            hintText: "+91 12345 67890",
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 16,
                              color: AppColors.neutral500,
                            ),
                            enabled: false,
                          ),

                          const Gap(40),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: AppTypography.style18W600.copyWith(
              color: AppColors.neutral900,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTypography.style14W400.copyWith(
              color: AppColors.neutral600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: AppTypography.style14W500.copyWith(
                  color: AppColors.neutral600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                appRouteState.logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                'Yes',
                style: AppTypography.style14W500.copyWith(
                  color: AppColors.textWhite,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
