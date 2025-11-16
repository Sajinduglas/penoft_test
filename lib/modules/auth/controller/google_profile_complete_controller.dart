import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';

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
      // TODO: When API is ready, uncomment and implement:
      // var res = await AuthRepository.googleSignUp(
      //   fullName: fullName.value,
      //   email: email.value,
      //   phoneNumber: phoneNumber.value,
      //   profilePicture: profilePictureUrl.value,
      //   idToken: idToken,
      //   accessToken: accessToken,
      // );
      // res.fold(
      //   (left) => Get.snackbar('Error', left.message),
      //   (right) async {
      //     await userController.onLoginIn(right.accessToken!, right.user ?? User());
      //     appRouteState.onLogin();
      //     await appRouteState.setProfileComplete(true);
      //     router.go('/${Dashboard.routeName}');
      //   },
      // );

      // For now, mock success
      final mockToken = "mock_token_${DateTime.now().millisecondsSinceEpoch}";
      final mockUser = User(
        id: "1",
        name: fullName.value,
        email: email.value,
      );

      await userController.onLoginIn(mockToken, mockUser);
      appRouteState.onLogin();
      await appRouteState.setProfileComplete(true);
      router.go('/${Dashboard.routeName}');
    }
  }
}

