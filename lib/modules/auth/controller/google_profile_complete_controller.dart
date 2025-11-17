import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/auth/repo/auth_repository.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';

class GoogleProfileCompleteController extends GetxController {
  final Map<String, dynamic> prefillData;

  GoogleProfileCompleteController({required this.prefillData});

  final GlobalKey<FormState> formKey = GlobalKey();

  // Form fields
  RxString fullName = RxString("");
  RxString email = RxString("");
  RxString phoneNumber = RxString("");
  RxString profilePictureUrl = RxString("");

  // Google tokens
  String? idToken;
  String? accessToken;

  @override
  void onInit() {
    super.onInit();
    // Pre-fill data from Google
    fullName.value = prefillData['fullname'] ?? '';
    email.value = prefillData['email'] ?? '';
    profilePictureUrl.value = prefillData['picture'] ?? '';
    idToken = prefillData['idToken'];
    accessToken = prefillData['accessToken'];
  }

  // Submit profile data to API
  Future<void> submitProfile() async {
    if (formKey.currentState!.validate()) {
      try {
        final res = await AuthRepository.createUser(
          fullname: fullName.value.trim(),
          email: email.value.trim(),
          phone: phoneNumber.value.trim().isNotEmpty
              ? phoneNumber.value.trim()
              : null,
          picture: profilePictureUrl.value.isNotEmpty
              ? profilePictureUrl.value
              : null,
        );

        await userController.onLoginIn(res.token, res.user);
        appRouteState.onLogin();
        await appRouteState.setProfileComplete(true);
        router.go('/${Dashboard.routeName}');
      } on ApiException catch (e) {
        Get.snackbar(
          'Error',
          e.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
