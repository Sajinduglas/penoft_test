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
import 'package:penoft_machine_test/shared/utils/snackbar.dart';

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
        fnShowSnackBarError('Please enter your full name');
        return;
      }

      final token = await LocalDb.getSavedToken();
      if (token == null || token.isEmpty) {
        fnShowSnackBarError('Session expired. Please login again');
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
        fnShowSnackBarSuccess('Full name saved successfully');
      } on ApiException catch (e) {
        fnShowSnackBarError(e.message);
      } catch (e) {
        fnShowSnackBarError(e.toString());
      }
    }
  }

  // Submit Profile Details (Screen 2 -> Screen 3)
  Future<void> onProfileSubmit() async {
    if (formKey.currentState!.validate()) {
      final token = await LocalDb.getSavedToken();
      if (token == null || token.isEmpty) {
        fnShowSnackBarError('Session expired. Please login again');
        return;
      }

      final imageFile = profileImage.value;
      if (imageFile == null) {
        fnShowSnackBarError('Please upload a profile picture');
        return;
      }

      try {
        await AuthRepository.uploadProfilePicture(
          token: token,
          image: imageFile,
        );
        showSuccess.value = true;
        fnShowSnackBarSuccess('Profile updated successfully');
      } on ApiException catch (e) {
        fnShowSnackBarError(e.message);
        // Navigate to success screen even if API fails
        showSuccess.value = true;
      } catch (e) {
        fnShowSnackBarError(e.toString());
        // Navigate to success screen even if API fails
        showSuccess.value = true;
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
      // Don't set profile complete here - only after both steps are done
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
