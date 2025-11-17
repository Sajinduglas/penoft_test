import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/modules/auth/screens/google_profile_complete/google_profile_complete.dart';

class GoogleAuthController extends GetxController {
  var isLoading = false.obs;

  // Using webClientId explicitly - this should match strings.xml
  // Make sure the SHA-1 fingerprint is registered in Google Cloud Console
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId:
        '158505151760-603n6v39617s41909288pq728os3ln6q.apps.googleusercontent.com',
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
      final idToken =
          auth.idToken; // JWT token to optionally verify server-side
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

      // Add a small delay to ensure UI is ready
      await Future.delayed(const Duration(milliseconds: 300));

      // navigate to google profile complete screen so user can edit phone and confirm
      debugPrint('Navigating to GoogleProfileCompleteScreen...');
      router.go('/${GoogleProfileCompleteScreen.routeName}');
      debugPrint('Navigation completed');
    } catch (e, st) {
      isLoading.value = false;
      debugPrint('Google Sign In Error: $e');
      debugPrint('Stack trace: $st');
      // Use debugPrint instead of snackbar to avoid context issues
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _prefillData = null;
  }
}
