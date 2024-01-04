import 'package:expense_tracker/src/utils/helpers/network_manager.dart';
import 'package:expense_tracker/src/utils/loaders/loader.dart';
import 'package:expense_tracker/src/utils/popups/full_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/authentication/authentication_repository.dart';
import '../../../../data/user/user_repository.dart';
import '../../models/user_model.dart';
import '../../screens/signup/validate_email.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final userRepo = Get.put(UserRepository());
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  void registerUser() async {
    try {
      //start Loading
      TcFullScreenLoader.openLoadingDialog(
          'We are processing your information...',
          'assets/animations/loadingData.json');

      //Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      //Form Validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy check
      if (!privacyPolicy.value) {
        TcLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
            'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.');
        return;
      }
      // Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());


      //Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);
      
      TcLoaders.successSnackBar(title: 'Congratulatons', message:'Your account has been created! Verify email to continue.');

      Get.to(()=>VerifyEmailScreen());

      
      // Show success Message
    } catch (e) {
      TcLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      TcFullScreenLoader.stopLoading();
    }
  }

  // Future<void> createUser(UserModel user) async {
  //   await userRepo.createUser(user);
  // }
}
