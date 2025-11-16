import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class ElevatedBtn extends StatefulWidget {
  final FutureOr<void> Function()? onPressed;
  final String label;
  const ElevatedBtn({super.key, required this.onPressed, required this.label});

  @override
  State<ElevatedBtn> createState() => _ElevatedBtnState();
}

class _ElevatedBtnState extends State<ElevatedBtn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
          onPressed: widget.onPressed != null
              ? () async {
                  setState(() {
                    isLoading = true;
                  });
                  await widget.onPressed?.call();
                  setState(() {
                    isLoading = false;
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.textWhite,
              fixedSize: const Size.fromHeight(53),
              padding: const EdgeInsets.symmetric(vertical: 7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              textStyle: AppTypography.style14W500),
          child: Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                const CupertinoActivityIndicator(
                  color: AppColors.textWhite,
                ),
              ],
              Text(widget.label,style: AppTypography.style14W500,),
            ],
          )),
    );
  }
}
