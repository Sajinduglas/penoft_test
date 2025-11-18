import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/modules/auth/screens/google_profile_complete/google_profile_complete.dart';
import 'package:penoft_machine_test/shared/utils/snackbar.dart';

class GoogleAuthController extends GetxController {
  var isLoading = false.obs;
  
  // Explicitly pass Web Client ID to ensure it's used correctly
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId: '158505151760-o6diiaihqv3kjkmojaa1v11mmn0fan9m.apps.googleusercontent.com',
  );

  // Store prefill data temporarily
  static Map<String, dynamic>? _prefillData;

  static Map<String, dynamic>? get prefillData => _prefillData;

  // Step 1: launch Google sign-in, get profile + idToken, navigate to profile confirm
  Future<void> googleLogin() async {
    try {
      isLoading.value = true;
      debugPrint('Starting Google Sign In...');
      
      final account = await _googleSignIn.signIn();
      debugPrint('Google Sign In result: ${account?.email ?? 'null'}');

      if (account == null) {
        // user cancelled
        debugPrint('User cancelled Google Sign In');
        isLoading.value = false;
        return;
      }

      debugPrint('Getting authentication...');
      final auth = await account.authentication;
      final idToken = auth.idToken; // JWT token to optionally verify server-side
      final accessToken = auth.accessToken;

      debugPrint('Google Sign In successful - Email: ${account.email}');
      debugPrint('ID Token: ${idToken != null ? 'Present' : 'Null'}');
      debugPrint('Access Token: ${accessToken != null ? 'Present' : 'Null'}');

      _prefillData = {
        'fullname': account.displayName ?? '',
        'email': account.email ?? '',
        'picture': account.photoUrl ?? '',
        'idToken': idToken ?? '',
        'accessToken': accessToken ?? '',
      };

      debugPrint('Prefill data stored: ${_prefillData?.keys}');
      isLoading.value = false;

      // Show success snackbar
      fnShowSnackBarSuccess('Google sign-in successful');

      // Add a small delay to ensure UI is ready and snackbar is shown
      await Future.delayed(const Duration(milliseconds: 500));

      // navigate to google profile complete screen so user can edit phone and confirm
      debugPrint('Navigating to GoogleProfileCompleteScreen...');
      router.go('/${GoogleProfileCompleteScreen.routeName}');
      debugPrint('Navigation completed');
    } catch (e, st) {
      isLoading.value = false;
      debugPrint('Google Sign In Error: $e');
      debugPrint('Stack trace: $st');
      
      // Show error snackbar
      fnShowSnackBarError(e.toString());
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _prefillData = null;
  }
}

