import 'package:get/get.dart';
import 'package:penoft_machine_test/config/local_db.dart';
import 'package:penoft_machine_test/modules/auth/repo/auth_repository.dart';
import 'package:penoft_machine_test/modules/user/controller/user_controller.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/shared/network/api_exception.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString(null);

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    isLoading.value = true;
    error.value = null;

    try {
      final token = await LocalDb.getSavedToken();
      if (token == null || token.isEmpty) {
        error.value = 'No authentication token found';
        isLoading.value = false;
        return;
      }

      final user = await AuthRepository.getUser(token);
      await userController.updateProfile(user);
    } on ApiException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  User get user => userController.user.value;
}
