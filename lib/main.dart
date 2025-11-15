import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:penoft_machine_test/modules/auth/screens/splash/splash.dart';
import 'package:penoft_machine_test/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  // usePathUrlStrategy();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Obx(
      () => userController.isLoading.value
          ? OKToast(
              child: Material(
              child: PenoftSplash(),
            ))
          : GetMaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: context.white.c500,
                textTheme:
                    GoogleFonts.interTextTheme(textTheme),
              ),
            
              builder: (context, child) {
                return child!;
              },
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
            ),
    );
  }
}