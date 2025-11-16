import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';

extension StringExtension on String {
  SvgPicture icon(BuildContext context, {Color? color}) => SvgPicture.asset(
        this,
        colorFilter:
            ColorFilter.mode(color ?? AppColors.neutral900, BlendMode.srcIn),
      );
}
