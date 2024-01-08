import 'package:expense_tracker/src/data/authentication/authentication_repository.dart';
import 'package:expense_tracker/src/data/user/user_repository.dart';
import 'package:expense_tracker/src/features/authentication/screens/login/login_page.dart';
import 'package:expense_tracker/src/features/personalization/modals/user_model.dart';
import 'package:expense_tracker/src/utils/constants/image_strings.dart';
import 'package:expense_tracker/src/utils/constants/sizes.dart';
import 'package:expense_tracker/src/utils/helpers/network_manager.dart';
import 'package:expense_tracker/src/utils/loaders/loader.dart';
import 'package:expense_tracker/src/utils/popups/full_screen_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../authentication/screens/login/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
      // profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      await fetchUserDetails();
      if (userCredential != null) {
        final nameParts =
        UserModel.nameParts(userCredential.user!.displayName ?? '');
        final username =
        UserModel.generateUsername(userCredential.user!.displayName ?? '');

        final user = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredential.user!.email ?? '',
          phoneNo: userCredential.user!.phoneNumber ?? '',
          photoURL: userCredential.user!.photoURL ?? '',
        );

        await userRepository.saveUserRecord(user);
      }
    } catch (e) {
      TcLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
          'Something went wrong saving your information. You can re-save your data in the Profile');
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TcSizes.md),
        title: 'Delete Acoount',
        middleText:
        'Are you sure you want to delete your acoount permanently? This action is not reversible and all of your data will be removed permenantly.',
        confirm: ElevatedButton(
            onPressed: () {},
            // onPressed: () => deleteUserAccount,
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: BorderSide(color: Colors.red)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: TcSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: Text('Cancel')));
  }

  /// working deleteUserAccountCode
  void deleteUserAccount() async {
    try {
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TcFullScreenLoader.stopLoading();
          Get.offAll(() => LoginPage());
        } else if (provider == 'password') {
          TcFullScreenLoader.stopLoading();
          Get.to(() => ReAuthLoginForm());
          //-->ReAuthLoginForm make another form for user to enter and confirm the credentials
        }
      }
    } catch (e) {
      TcFullScreenLoader.stopLoading();
      TcLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      TcFullScreenLoader.openLoadingDialog(
          'Processing', TcImages.loadingDataImage);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TcFullScreenLoader.stopLoading();
        return;
      }
      if (!reAuthFormKey.currentState!.validate()) {
        TcFullScreenLoader.stopLoading();
        return;
      }
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      TcFullScreenLoader.stopLoading();
      Get.offAll(() => LoginPage());
    } catch (e) {
      TcFullScreenLoader.stopLoading();
      TcLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  uploadUserProfilePicture() async {
    try{
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        final imageUrl =
        await userRepository.uploadImage('User/Images/Profile/', image);
        Map<String, dynamic> json = {'Photo': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.photoURL = imageUrl;
        TcLoaders.successSnackBar(title: 'Congratulations',message: 'Your profile Image has been updated');

      }

    }catch (e){
      TcLoaders.errorSnackBar(title: 'Oh snap!', message: 'Something went wrong: $e');
    }

  }
}
