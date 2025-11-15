
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';
import 'package:penoft_machine_test/shared/utils/validator.dart';
import 'package:penoft_machine_test/shared/widgets/buttons/elevated_btn.dart';
import 'package:penoft_machine_test/shared/widgets/inputfield/inputform.dart';

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
          if (controller.showOtp.value) {
            controller.showOtp(false);
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 263,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: context.black.c900,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Assets.images.loginBg.provider())),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 26, horizontal: 14),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.showOtp.value)
                              InkWell(
                                  onTap: () {
                                    controller.showOtp(false);
                                  },
                                  child: Assets.svg.icons.backArrow
                                      .icon(context, color: context.white.c50)),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                "Log in to your\nAccount",
                                textAlign: TextAlign.left,
                                style: AppTypography.headlineMedium.copyWith(
                                    color: context.white.c50,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(125),
                SizedBox(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Obx(
                              () => controller.showOtp.value
                                  ? CustomOtpTextfeild(
                                      onCodeChanged: (p0) {
                                        devPrint(p0);
                                        controller.otp(int.parse(p0));
                                      },
                                    )
                                  : InputForm(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (p0) {
                                        controller.btnSubmit();
                                      },
                                    
                                      onChanged: (p0) {
                                        controller.mobileNumber(p0);
                                      },
                                      validator: emailValidator,
                                      initialValue:
                                          controller.mobileNumber.value,
                                      label: "Mobile",
                                      hintText: "Enter Mobile "),
                            ),
                            const Gap(44),
                            ElevatedBtn(
                              label: "Log In",
                              onPressed: controller.btnSubmit,
                            ),
                            const Gap(32),
                            InkWell(
                              onTap: () {
                                router.pushNamed(SignUpPage.routeName);
                              },
                              child: Obx(
                                () => RichText(
                                    text: TextSpan(
                                        text: controller.showOtp.value
                                            ? "Haven't got the confirmation code yet?"
                                            : "Don’t have an account?",
                                        children: [
                                          TextSpan(
                                              text: controller.showOtp.value
                                                  ? " Resend"
                                                  : " Sign Up",
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  if (controller
                                                      .showOtp.value) {
                                                    controller
                                                        .onMobileNumberSubmit();
                                                  } else {
                                                    router.goNamed(
                                                        SignUpPage.routeName);
                                                  }
                                                },
                                              style: AppTypography.caption
                                                  .copyWith(
                                                      color: const Color(
                                                          0xff0074BA)))
                                        ],
                                        style: AppTypography.caption.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: context.black.c900))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
