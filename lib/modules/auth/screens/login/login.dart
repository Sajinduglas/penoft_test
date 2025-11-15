
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/modules/auth/controller/login_controller.dart';
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
          backgroundColor: const Color(0xFFFFFFFF),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // ---------------------- HEADER SECTION ----------------------
                  SizedBox(
                    height: 263,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        // image: DecorationImage(
                        //   fit: BoxFit.cover,
                        //   image: Assets.images.loginBg.provider(),
                        // ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 26, horizontal: 14),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (controller.showOtp.value)
                                InkWell(
                                  onTap: () => controller.showOtp(false),
                                  child:Icon(Icons.abc_outlined)
                                ),
                              const Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  controller.showOtp.value
                                      ? "Enter verification code"
                                      : "Enter your email",
                                  style: AppTypography.style14W400.copyWith(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Gap(40),

                  // ---------------------- BODY SECTION ----------------------
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Form(
                      key: controller.formKey,
                      child: Obx(
                        () => controller.showOtp.value
                            ? _otpUI()
                            : _emailUI(),
                      ),
                    ),
                  ),
                ],
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
            text: "Don’t have an account? ",
            style: AppTypography.style14W400.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A),
            ),
            children: [
              TextSpan(
                text: "Sign Up",
                style: AppTypography.style14W400.copyWith(
                  color: const Color(0xFF0074BA),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // return router.goNamed(SignUpPage.routeName);
                  } ,
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
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              "Enter the verification code sent to your email",
              style: AppTypography.style14W400.copyWith(
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ),

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
              "Didn’t receive the code? ",
              style: AppTypography.style14W400.copyWith(
                color: const Color(0xFF0F172A),
              ),
            ),
            GestureDetector(
              onTap: () => controller.onEmailSubmit(),
              child: Text(
                "Resend",
                style: AppTypography.style14W400.copyWith(
                  color: const Color(0xFF0074BA),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
