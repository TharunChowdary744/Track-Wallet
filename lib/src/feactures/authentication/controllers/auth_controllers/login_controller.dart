import 'package:expense_tracker/glober/logger.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';

import '../../../../repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();


  Future<void> googleLogin() async {
    logger.e("tap");
    AuthenticationRepository.instance.loginInWithGoogle();


  }

  Future<void> emailAndPasswordLogin(String email, String password) async {
    // Handle email and password Sign In logic
  }
}