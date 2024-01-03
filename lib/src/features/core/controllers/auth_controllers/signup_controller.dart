import 'package:expense_tracker/glober/logger.dart';
import 'package:expense_tracker/src/utils/helpers/network_manager.dart';
import 'package:expense_tracker/src/features/core/models/user_model.dart';
import 'package:expense_tracker/src/repository/user_repository/user_repository.dart';
import 'package:expense_tracker/src/utils/loaders/loader.dart';
import 'package:expense_tracker/src/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final userRepo = Get.put(UserRepository());
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    logger.i('{Email-->${email.text} + Password-->${password.text}');
    logger.i(await signupFormKey.currentState!.toString());
    try {
      //start Loading
      TcFullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          'assets/animations/loadingData.json');

      //Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //Form Validation
      if (signupFormKey.currentState!.validate()) return;

      // Privacy Policy check
      if (!privacyPolicy.value) {
        TcLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
        return;
      }

      //Save Authenticated user data in the Firebase Firestore

      // Show success Message
      // AuthenticationRepository.instance.createUserWithEmailAndPassword(email.text, password.text);
    } catch (e) {
      TcLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      TcFullScreenLoader.stopLoading();
    }
  }

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }
}
