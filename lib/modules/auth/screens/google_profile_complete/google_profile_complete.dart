import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/auth/controller/google_auth_controller.dart';
import 'package:penoft_machine_test/modules/auth/controller/google_profile_complete_controller.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';
import 'package:penoft_machine_test/shared/utils/tag_generator.dart';
import 'package:penoft_machine_test/shared/widgets/buttons/elevated_btn.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/inputform.dart';

class GoogleProfileCompleteScreen extends StatefulWidget {
  static const routeName = 'googleProfileComplete';

  const GoogleProfileCompleteScreen({super.key});

  @override
  State<GoogleProfileCompleteScreen> createState() =>
      _GoogleProfileCompleteScreenState();
}

class _GoogleProfileCompleteScreenState
    extends State<GoogleProfileCompleteScreen> {
  late GoogleProfileCompleteController controller;
  final String tag = tagGenerator();

  @override
  void initState() {
    super.initState();
    // Get prefill data from GoogleAuthController (static getter)
    final prefillData = GoogleAuthController.prefillData ?? {};
    controller = Get.put(
      GoogleProfileCompleteController(prefillData: prefillData),
      tag: tag,
    );
  }

  @override
  void dispose() {
    Get.delete<GoogleProfileCompleteController>(tag: tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),

                // Back button
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: Assets.svg.backArrow.icon(context).square(12),
                    ),
                    const Gap(12),
                    Text(
                      "Back",
                      style: AppTypography.style14W400.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),
                  ],
                ),
                const Gap(34),

                // Title
                Text(
                  "Your Profile",
                  style: AppTypography.style18W600.copyWith(
                    color: AppColors.neutral900,
                  ),
                ),
                const Gap(12),
                Text(
                  "If needed you can change the details by clicking on them",
                  style: AppTypography.style14W400.copyWith(
                    color: AppColors.neutral600,
                  ),
                ),
                const Gap(40),

                // Form Content
                Form(
                  key: controller.formKey,
                  child: _profileFormUI(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileFormUI() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  child: controller.profilePictureUrl.value.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            controller.profilePictureUrl.value,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
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

          // Full Name Input
          InputForm(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            onChanged: (v) => controller.fullName.value = v,
            initialValue: controller.fullName.value,
            label: "Full name",
            hintText: "Enter your full name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),

          const Gap(20),

          // Email Input
          InputForm(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (v) => controller.email.value = v,
            initialValue: controller.email.value,
            label: "Mail Id",
            hintText: "Enter your email",
            prefixIcon: Assets.svg.mail
                .icon(context, color: AppColors.neutral500)
                .square(12),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!GetUtils.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          const Gap(20),

          // Phone Number Input
          InputForm(
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => controller.submitProfile(),
            onChanged: (v) => controller.phoneNumber.value = v,
            initialValue: controller.phoneNumber.value,
            label: "Phone Number",
            hintText: "+91 12345 67890",
            prefixIcon: Icon(
              Icons.phone,
              size: 16,
              color: AppColors.neutral500,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),

          const Gap(40),

          ElevatedBtn(
            label: "Continue",
            onPressed: controller.submitProfile,
          ),
        ],
      ),
    );
  }
}

