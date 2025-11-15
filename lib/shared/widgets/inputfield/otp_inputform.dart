
import 'package:flutter/cupertino.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


class CustomOtpTextfeild extends StatelessWidget {
  final Function(String)? onCodeChanged;
  const CustomOtpTextfeild({super.key, this.onCodeChanged});

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderRadius: BorderRadius.circular(10),
      borderColor: Color(0xFF64748B),
      focusedBorderColor: Color(0xFF0F172A),
      borderWidth: 1,
      showFieldAsBox: true,
      enabledBorderColor:  Color(0xFF64748B),
      fillColor:  Color(0xFFFFFFFF),

      cursorColor: Color(0xFF0F172A),
      disabledBorderColor:Color(0xFF64748B),
      // onCodeChanged:onCodeChanged,

      // decoration: AppDecoration.fieldDecoration,
      //runs when every textfield is filled
      onSubmit: onCodeChanged, // end onSubmit
    );
  }
}
