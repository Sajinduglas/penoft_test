import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';

class ProfileCompleteController extends GetxController {
  ProfileCompleteController();

  // Screen state booleans
  final RxBool showProfileDetails = RxBool(false);
  final RxBool showSuccess = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();

  // Full Name (Screen 1)
  RxString fullName = RxString("");

  // Profile Details (Screen 2)
  RxString profileName = RxString("");
  RxString profileEmail = RxString("");
  // File upload will be added later
  RxString? profileImagePath = RxString("");
  Rx<XFile?> profileImage = Rx<XFile?>(null);
  void setProfileImage(XFile? image) {
    profileImage.value = image;
  }

  // Submit Full Name (Screen 1 -> Screen 2)
  Future<void> onFullNameSubmit([bool? bypassValidation]) async {
    if ((bypassValidation ?? false) || formKey.currentState!.validate()) {
      // TODO: API call for full name submission
      // var res = await ProfileRepository.submitFullName(fullName.value);
      // res.fold(
      //   (left) => fnShowSnackBarError(left.message),
      //   (right) => showProfileDetails(true),
      // );

      // For now, just show profile details screen
      profileName.value = fullName.value;
      showProfileDetails.value = true;
    }
  }

  // Submit Profile Details (Screen 2 -> Screen 3)
  Future<void> onProfileSubmit() async {
    if (formKey.currentState!.validate()) {
      // TODO: API call for profile completion
      // var res = await ProfileRepository.completeProfile(
      //   name: profileName.value,
      //   email: profileEmail.value,
      //   image: profileImagePath.value,
      // );
      // res.fold(
      //   (left) => fnShowSnackBarError(left.message),
      //   (right) {
      //     userController.updateProfile(right.user);
      //     showSuccess.value = true;
      //   },
      // );

      // For now, update user data and show success screen
      final currentUser = userController.user.value;
      final updatedUser = User(
        id: currentUser.id,
        name: profileName.value,
        email: profileEmail.value,
      );
      await userController.updateProfile(updatedUser);
      showSuccess.value = true;
    }
  }

  // Main button handler
  Future<void> btnSubmit() async {
    if (showSuccess.value) {
      // Set profile completion status to true
      await appRouteState.setProfileComplete(true);
      // Navigate to dashboard
      router.go('/${Dashboard.routeName}');
    } else if (showProfileDetails.value) {
      await onProfileSubmit();
    } else {
      await onFullNameSubmit();
    }
  }

  // File upload handler (placeholder for now)
  Future<void> onFileUpload() async {
    // TODO: Implement file upload
    // This will be replaced with actual file upload widget later
  }

  @override
  void onInit() {
    super.onInit();
    // Pre-populate with existing user data if available
    final currentUser = userController.user.value;
    if (currentUser.name != null && currentUser.name!.isNotEmpty) {
      fullName.value = currentUser.name!;
      profileName.value = currentUser.name!;
    }
    if (currentUser.email != null && currentUser.email!.isNotEmpty) {
      profileEmail.value = currentUser.email!;
    }
  }
}
