import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penoft_machine_test/gen/assets.gen.dart';
import 'package:penoft_machine_test/modules/auth/screens/login/login.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/shared/constants/colors.dart';
import 'package:penoft_machine_test/shared/constants/typography.dart';

class PenoftSplash extends StatefulWidget {
  static const routeName = 'splashScreen';

  const PenoftSplash({super.key});

  @override
  State<PenoftSplash> createState() => _PenoftSplashState();
}

class _PenoftSplashState extends State<PenoftSplash> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  void _checkAuthAndNavigate() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        if (appRouteState.isUserLoggedIn) {
          context.go('/${Dashboard.routeName}');
        } else {
          context.go('/${LoginPage.routeName}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 120,
              width: 120,
              child: Assets.png.penoftSpalsh.image(
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
          ),
          Gap(24),
       
          /// ⭐ Text with GoogleFonts Inter Tight
          Text(
            "educatory",
            style: GoogleFonts.interTight(
              fontSize: 52,
              fontWeight: FontWeight.w700,
              color: AppColors.neutral900,
            ),
          ),
        ],
      ),
    );
  }
}
