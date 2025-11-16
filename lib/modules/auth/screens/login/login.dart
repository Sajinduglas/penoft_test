import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/modules/auth/controller/login_controller.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/utils/tag_generator.dart';
import 'package:penoft_machine_test/shared/widgets/buttons/elevated_btn.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/inputform.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/otp_inputform.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';
  final String? phNumber;

  const LoginPage({super.key, this.phNumber});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController controller;
  final String tag = tagGenerator();

  @override
  void initState() {
    controller = Get.put(LoginController(phNumber: widget.phNumber), tag: tag);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LoginController>(tag: tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: !controller.showOtp.value,
        onPopInvokedWithResult: (didPop, result) {
          if (controller.showOtp.value) controller.showOtp(false);
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
                    
                    // Back button (only for OTP screen)
                    if (controller.showOtp.value) ...[
                      InkWell(
                        onTap: () => controller.showOtp(false),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Gap(24),
                    ],

                    // Title
                    Text(
                      controller.showOtp.value
                          ? "Enter verification code"
                          : "Enter your email",
                      style: AppTypography.style18W600.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    
                    const Gap(40),

                    // Form Content
                    Form(
                      key: controller.formKey,
                      child: Obx(
                        () => controller.showOtp.value
                            ? _otpUI()
                            : _emailUI(),
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
        InputForm(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => controller.btnSubmit(),
          onChanged: (v) => controller.email(v),
          initialValue: controller.email.value,
          label: "Email",
          hintText: "penoftdesign@gmail.com",
        ),

        const Gap(32),

        ElevatedBtn(
          label: "Continue",
          onPressed: controller.btnSubmit,
        ),

        const Gap(16),

        RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: AppTypography.style14W400.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            children: [
              TextSpan(
                text: "Sign Up",
                style: AppTypography.style14W400.copyWith(
                  color: AppColors.textLink,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // return router.goNamed(SignUpPage.routeName);
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
                style: AppTypography.style14W400.copyWith(
                  color: AppColors.textSecondary,
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
        OutlinedButton(
          onPressed: () {
            // TODO: Implement Google sign in
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
              // Google G icon (simplified - you can replace with actual Google icon)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    "G",
                    style: AppTypography.style14W500.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Text(
                "Continue with Google",
                style: AppTypography.style14W400.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
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
          "Enter the verification code sent to ${controller.email.value.isNotEmpty ? controller.email.value : 'your email'}",
          style: AppTypography.style14W400.copyWith(
            color: AppColors.textSecondary,
          ),
        ),

        const Gap(24),

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

        const Gap(16),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style: AppTypography.style14W400.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () => controller.onEmailSubmit(),
              child: Text(
                "Resend",
                style: AppTypography.style14W400.copyWith(
                  color: AppColors.textLink,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
