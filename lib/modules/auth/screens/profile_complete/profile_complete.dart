import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/auth/controller/profile_complete_controller.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';
import 'package:penoft_machine_test/shared/utils/tag_generator.dart';
import 'package:penoft_machine_test/shared/widgets/app_profile_picker.dart';
import 'package:penoft_machine_test/shared/widgets/buttons/elevated_btn.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/inputform.dart';

class ProfileCompletePage extends StatefulWidget {
  static const routeName = 'profileComplete';

  const ProfileCompletePage({super.key});

  @override
  State<ProfileCompletePage> createState() => _ProfileCompletePageState();
}

class _ProfileCompletePageState extends State<ProfileCompletePage> {
  late ProfileCompleteController controller;
  final String tag = tagGenerator();

  @override
  void initState() {
    controller = Get.put(ProfileCompleteController(), tag: tag);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ProfileCompleteController>(tag: tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !controller.showProfileDetails.value && !controller.showSuccess.value,
        onPopInvokedWithResult: (didPop, result) {
          if (controller.showSuccess.value) {
            controller.showSuccess.value = false;
          } else if (controller.showProfileDetails.value) {
            controller.showProfileDetails.value = false;
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),

                    // Back button (for Screen 2 and 3)
                    if (controller.showProfileDetails.value || controller.showSuccess.value) ...[
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (controller.showSuccess.value) {
                                controller.showSuccess.value = false;
                              } else if (controller.showProfileDetails.value) {
                                controller.showProfileDetails.value = false;
                              }
                            },
                            child: Assets.svg.backArrow.icon(context).square(14),
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
                    ],

                    // Form Content
                    Form(
                      key: controller.formKey,
                      child: Obx(
                        () => controller.showSuccess.value
                            ? _successUI()
                            : controller.showProfileDetails.value
                                ? _profileDetailsUI()
                                : _fullNameUI(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ----------------------------- SCREEN 1: FULL NAME UI -----------------------------
  Widget _fullNameUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your name?",
          style: AppTypography.style18W600.copyWith(
            color: AppColors.neutral900,
          ),
        ),
        const Gap(40),
        InputForm(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => controller.btnSubmit(),
          onChanged: (v) => controller.fullName.value = v,
          initialValue: controller.fullName.value,
          label: "Full Name",
          hintText: "Name Name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
        const Gap(20),
        ElevatedBtn(
          label: "Continue",
          onPressed: controller.btnSubmit,
        ),
      ],
    );
  }

  // ----------------------------- SCREEN 2: PROFILE DETAILS UI -----------------------------
  Widget _profileDetailsUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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

        // // Profile Picture Section with File Upload
        // Center(
        //   child: Column(
        //     children: [
        //       Container(
        //         width: 120,
        //         height: 120,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           border: Border.all(
        //             color: AppColors.primary,
        //             width: 2,
        //           ),
        //         ),
        //         child: InkWell(
        //           onTap: controller.onFileUpload,
        //           child: controller.profileImagePath?.value != null
        //               ? ClipOval(
        //                   child: Image.asset(
        //                     controller.profileImagePath!.value!,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 )
        //               : Icon(
        //                   Icons.camera_alt,
        //                   color: AppColors.primary,
        //                   size: 40,
        //                 ),
        //         ),
        //       ),
        //       const Gap(12),
        //       Text(
        //         "File Upload",
        //         style: AppTypography.style14W400.copyWith(
        //           color: AppColors.neutral600,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
 AppProfilePicker(
                      onFileChange: (image) {
                        controller.setProfileImage(image);
                      },
                      image: controller.profileImage.value,
                    ),
        const Gap(12),

        // Full Name Input
        InputForm(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: (v) => controller.profileName.value = v,
          initialValue: controller.profileName.value.isNotEmpty
              ? controller.profileName.value
              : "Fetched Name",
          label: "Full name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),

        const Gap(12),

        // Mail Id Input
        InputForm(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => controller.btnSubmit(),
          onChanged: (v) => controller.profileEmail.value = v,
          initialValue: controller.profileEmail.value.isNotEmpty
              ? controller.profileEmail.value
              : "fetchedemailid@gmail.com",
          label: "Mail Id",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),

        const Gap(32),

        ElevatedBtn(
          label: "Continue",
          onPressed: controller.btnSubmit,
        ),
      ],
    );
  }

  // ----------------------------- SCREEN 3: SUCCESS UI -----------------------------
  Widget _successUI() {
    return Column(
      
      children: [
        const Gap(60),
        // Success Image
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.6,
          child: Assets.png.successMsg.image(
            fit: BoxFit.contain,
          ),
        ),
        // const Gap(40),
        // Text(
        //   "Congrats!",
        //   style: AppTypography.style18W600.copyWith(
        //     fontSize: 24,
        //     fontWeight: FontWeight.w700,
        //     color: AppColors.neutral900,
        //   ),
        // ),
        // const Gap(16),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child: Text(
        //     "You have signed up successfully. Go to home & start exploring courses",
        //     textAlign: TextAlign.center,
        //     style: AppTypography.style14W400.copyWith(
        //       color: AppColors.neutral600,
        //     ),
        //   ),
        // ),
        const Gap(26),
        ElevatedBtn(
          label: "Go to Home",
          onPressed: controller.btnSubmit,
        ),
      ],
    );
  }
}

