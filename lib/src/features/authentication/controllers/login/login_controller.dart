import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter/material.dart';

import '../../../../data/authentication/authentication_repository.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey  = GlobalKey<FormState>();


  Future<void> googleLogin() async {
    AuthenticationRepository.instance.loginInWithGoogle();


  }

  Future<void> emailAndPasswordLogin(String email, String password) async {
    await AuthenticationRepository.instance.loginWithEmailAndPassword(email, password);
  }
}