import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/auth/controller/google_auth_controller.dart';
import 'package:penoft_machine_test/modules/auth/controller/sign_up_controller.dart';
import 'package:penoft_machine_test/modules/auth/screens/login/login.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/extension/square.dart';
import 'package:penoft_machine_test/shared/extension/string.dart';
import 'package:penoft_machine_test/shared/utils/tag_generator.dart';
import 'package:penoft_machine_test/shared/utils/validator.dart';
import 'package:penoft_machine_test/shared/widgets/buttons/elevated_btn.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/inputform.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/otp_inputform.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = 'signup';
  final String? phNumber;

  const SignUpPage({super.key, this.phNumber});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpController controller;
  late GoogleAuthController googleAuthController;
  final String tag = tagGenerator();
  final String googleTag = tagGenerator();

  @override
  void initState() {
    controller = Get.put(SignUpController(phNumber: widget.phNumber), tag: tag);
    googleAuthController = Get.put(GoogleAuthController(), tag: googleTag);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SignUpController>(tag: tag);
    Get.delete<GoogleAuthController>(tag: googleTag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !controller.showOtp.value,
        onPopInvokedWithResult: (didPop, result) {
          if (controller.showOtp.value) {
            controller.showOtp(false);
            controller.stopTimer();
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),

                    // Back button (only for OTP screen)
                    if (controller.showOtp.value) ...[
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.showOtp(false);
                              controller.stopTimer();
                            },
                            child:
                                Assets.svg.backArrow.icon(context).square(12),
                          ),
                          Gap(12),
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

                    // Title
                    Text(
                      controller.showOtp.value
                          ? "Enter verification code"
                          : "Enter your email",
                      style: AppTypography.style18W600.copyWith(
                        color: AppColors.neutral900,
                      ),
                    ),

                    const Gap(12),

                    // Form Content
                    Form(
                      key: controller.formKey,
                      child: Obx(
                        () => controller.showOtp.value ? _otpUI() : _emailUI(),
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

  // ----------------------------- EMAIL UI -----------------------------
  Widget _emailUI() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Enter your email to receive verification code.",
              style: AppTypography.style14W400.copyWith(
                color: AppColors.neutral600,
              ),
            ),
          ],
        ),

        const Gap(40),
        InputForm(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => controller.btnSubmit(),
          onChanged: (v) => controller.email(v),
          initialValue: controller.email.value,
          label: "Email",
          validator: emailValidator,
          hintText: "Enter your email",
          prefixIcon: Assets.svg.mail
              .icon(context, color: AppColors.neutral500)
              .square(12),
        ),

        const Gap(20),

        ElevatedBtn(
          label: "Continue",
          onPressed: controller.btnSubmit,
        ),

        const Gap(32),

        RichText(
          text: TextSpan(
            text: "Already have an account? ",
            style: AppTypography.style14W400.copyWith(
              color: AppColors.neutral500,
            ),
            children: [
              TextSpan(
                text: "Login",
                style: AppTypography.style14W400.copyWith(
                  color: AppColors.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.go('/${LoginPage.routeName}');
                  },
              ),
            ],
          ),
        ),

        const Gap(32),

        // OR Separator
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppColors.borderLight,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "OR",
                style: AppTypography.style12W400.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppColors.borderLight,
                thickness: 1,
              ),
            ),
          ],
        ),

        const Gap(32),

        // Continue with Google Button
        Obx(
          () => OutlinedButton(
            onPressed: googleAuthController.isLoading.value
                ? null
                : () {
                    googleAuthController.googleLogin();
                  },
            style: OutlinedButton.styleFrom(
              backgroundColor: AppColors.backgroundWhite,
              side: const BorderSide(color: AppColors.borderLight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: const Size(double.infinity, 56),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google G icon
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Assets.svg.googleNew.icon(context).square(12),
                  ),
                ),
                const Gap(12),
                Text(
                  "Continue with Google",
                  style: AppTypography.style14W400.copyWith(
                    color: AppColors.neutral900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ----------------------------- OTP UI -----------------------------
  Widget _otpUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter the verification code sent to",
          style: AppTypography.style14W400.copyWith(
            color: AppColors.neutral600,
          ),
        ),
        Text(
          " ${controller.email.value.isNotEmpty ? controller.email.value : 'your email'}",
          style: AppTypography.style14W400.copyWith(
            color: AppColors.primary,
          ),
        ),
        const Gap(12),
        CustomOtpTextfeild(
          onCodeChanged: (code) {
            if (code.isNotEmpty) {
              try {
                controller.otp(int.parse(code));
              } catch (_) {
                controller.otp(null);
              }
            } else {
              controller.otp(null);
            }
          },
        ),
        const Gap(32),
        ElevatedBtn(
          label: "Continue",
          onPressed: controller.btnSubmit,
        ),
        const Gap(20),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive the code? ",
                style: AppTypography.style14W400.copyWith(
                  color: AppColors.neutral500,
                ),
              ),
              if (controller.canResend.value)
                GestureDetector(
                  onTap: () => controller.resendOtp(),
                  child: Text(
                    "Resend",
                    style: AppTypography.style14W400.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                )
              else
                Text(
                  "Resend in ${controller.formattedTimerText}",
                  style: AppTypography.style14W400.copyWith(
                    color: AppColors.primary,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
