import 'package:flutter/material.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class BookScreen extends StatelessWidget {
  static const routeName = 'book';

  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Text(
          'Book',
          style: AppTypography.style18W600.copyWith(
            color: AppColors.neutral900,
          ),
        ),
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Book Screen',
          style: AppTypography.style18W600.copyWith(
            color: AppColors.neutral900,
          ),
        ),
      ),
    );
  }
}

