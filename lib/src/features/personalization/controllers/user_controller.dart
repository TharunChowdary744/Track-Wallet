import 'package:expense_tracker/src/data/user/user_repository.dart';
import 'package:expense_tracker/src/features/personalization/modals/user_model.dart';
import 'package:expense_tracker/src/utils/loaders/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final nameParts = UserModel.nameParts(
            userCredential.user!.displayName ?? '');
        final username = UserModel.generateUsername(
            userCredential.user!.displayName ?? '');

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
      TcLoaders.warningSnackBar(title: 'Data not saved',
          message: 'Something went wrong saving your information. You can re-save your data in the Profile');
    }
  }
}