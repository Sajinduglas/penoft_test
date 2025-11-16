import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:penoft_machine_test/routes/routes.dart';
import 'package:penoft_machine_test/modules/auth/screens/google_profile_complete/google_profile_complete.dart';

class GoogleAuthController extends GetxController {
  var isLoading = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  // Store prefill data temporarily
  static Map<String, dynamic>? _prefillData;

  static Map<String, dynamic>? get prefillData => _prefillData;

  // Step 1: launch Google sign-in, get profile + idToken, navigate to profile confirm
  Future<void> googleLogin() async {
    try {
      isLoading.value = true;
      final account = await _googleSignIn.signIn();

      if (account == null) {
        // user cancelled
        isLoading.value = false;
        return;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken; // JWT token to optionally verify server-side
      final accessToken = auth.accessToken;

      _prefillData = {
        'fullname': account.displayName ?? '',
        'email': account.email ?? '',
        'picture': account.photoUrl ?? '',
        'idToken': idToken ?? '',
        'accessToken': accessToken ?? '',
      };

      // navigate to google profile complete screen so user can edit phone and confirm
      router.go('/${GoogleProfileCompleteScreen.routeName}');
    } catch (e, st) {
      Get.snackbar('Login Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    _prefillData = null;
  }
}

