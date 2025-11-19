import 'package:flutter/cupertino.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';

class CustomOtpTextfeild extends StatelessWidget {
  final Function(String)? onCodeChanged;
  const CustomOtpTextfeild({super.key, this.onCodeChanged});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderRadius: BorderRadius.circular(10),
      borderColor: AppColors.neutral300,
      focusedBorderColor: AppColors.primary,
      borderWidth: .8,
      showFieldAsBox: true,
      enabledBorderColor: AppColors.neutral300,
      fillColor: Color(0xFFFFFFFF),

      cursorColor: AppColors.primary,
      disabledBorderColor: AppColors.neutral300,
      // onCodeChanged:onCodeChanged,

      // decoration: AppDecoration.fieldDecoration,
      //runs when every textfield is filled
      onSubmit: onCodeChanged, // end onSubmit
    );
  }
}
