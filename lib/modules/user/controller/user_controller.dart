import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penoft_machine_test/config/local_db.dart';
import 'package:penoft_machine_test/modules/user/model/user.dart';
import 'package:penoft_machine_test/routes/route_state.dart';

class _UserController extends GetxController {
  Rx<User> user = User().obs;
  final RxBool isLoading = true.obs;

  Future<void> onLoginIn(String accessToken, User userData) async {
    await LocalDb.saveToken(accessToken);
    await LocalDb.saveUser(userData);
    user.value = userData;
    appRouteState.onLogin();
  }

  Future<void> initial() async {
    var token = await LocalDb.getSavedToken();
    if (token == null) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          isLoading.value = false;
        },
      );
    } else {
      user.value = await LocalDb.getSavedUser() ?? User();
      // TODO: When API is ready, uncomment and implement:
      // var res = await LoginRepository.meApi();
      // res.fold(
      //   (left) {},
      //   (right) async {
      //     await LocalDb.saveUser(right.user ?? User());
      //     user.value = right.user ?? User();
      //   },
      // );
      appRouteState.onLogin();
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    initial();
    super.onInit();
  }
}

final userController = Get.put(_UserController());

