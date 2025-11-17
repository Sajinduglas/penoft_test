import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:penoft_machine_test/config/local_db.dart';
import 'package:penoft_machine_test/modules/auth/repo/auth_repository.dart';
import 'package:penoft_machine_test/modules/dashboard/screens/dashboard.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/routes/route_state.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';

class ProfileCompleteController extends GetxController {
  ProfileCompleteController();

  // Screen state booleans
  final RxBool showProfileDetails = RxBool(false);
  final RxBool showSuccess = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey();

  // Full Name (Screen 1)
  RxString fullName = RxString("");

  Rx<XFile?> profileImage = Rx<XFile?>(null);
  void setProfileImage(XFile? image) {
    profileImage.value = image;
  }

  // Submit Full Name (Screen 1 -> Screen 2)
  Future<void> onFullNameSubmit([bool? bypassValidation]) async {
    if ((bypassValidation ?? false) || formKey.currentState!.validate()) {
      final currentFullName = fullName.value.trim();
      if (currentFullName.isEmpty) {
        Get.snackbar(
          'Validation',
          'Please enter your full name',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final token = await LocalDb.getSavedToken();
      if (token == null || token.isEmpty) {
        Get.snackbar(
          'Session expired',
          'Please login again',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      try {
        await AuthRepository.addFullName(
          token: token,
          fullName: currentFullName,
        );

        final existingUser = userController.user.value;
        await userController.updateProfile(
          User(
            id: existingUser.id,
            name: currentFullName,
            email: existingUser.email,
          ),
        );
        showProfileDetails.value = true;
        Get.snackbar(
          'Success',
          'Full name saved',
          snackPosition: SnackPosition.BOTTOM,
        );
      } on ApiException catch (e) {
        Get.snackbar(
          'Update failed',
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

  // Submit Profile Details (Screen 2 -> Screen 3)
  Future<void> onProfileSubmit() async {
    if (formKey.currentState!.validate()) {
      final token = await LocalDb.getSavedToken();
      if (token == null || token.isEmpty) {
        Get.snackbar(
          'Session expired',
          'Please login again',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final imageFile = profileImage.value;
      if (imageFile == null) {
        Get.snackbar(
          'Validation',
          'Please upload a profile picture',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      try {
        await AuthRepository.uploadProfilePicture(
          token: token,
          image: imageFile,
        );
        showSuccess.value = true;
        Get.snackbar(
          'Profile updated',
          'You are all set!',
          snackPosition: SnackPosition.BOTTOM,
        );
      } on ApiException catch (e) {
        Get.snackbar(
          'Update failed',
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
  @override
  void onInit() {
    super.onInit();
    // Pre-populate with existing user data if available
    final currentUser = userController.user.value;
    if (currentUser.name != null && currentUser.name!.isNotEmpty) {
      fullName.value = currentUser.name!;
    }
  }
}
