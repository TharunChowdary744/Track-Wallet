import 'package:expense_tracker/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../glober/logger.dart';
import '../../exceptions/signup_email_password_failure.dart';
import '../../features/core/models/user_model.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

// Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => ('/login'))
        : Get.offAll(() => ('/home') /*WelcomeScreen()*/);
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // firebaseUser.value != null
      //     ? Get.offAll(() => ('/home'))
      //     : Get.offAll(() => /*WelcomeScreen()*/ ('/login'));
      User? user = _auth.currentUser;
      logger.i("+++++++++++++>>>>>$user");
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      logger.w("===fffffff====>>>>>${ex.message}");
      Get.snackbar('Error', ex.message.toString(),
          snackPosition: SnackPosition.BOTTOM);

      throw ex;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure.code("");
      logger.w("===-------====>>>>>${ex.message}");
      Get.snackbar('Error', ex.message.toString(),
          snackPosition: SnackPosition.BOTTOM);

      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      logger.i("+++++++++++++>>>>>${_auth.currentUser}");
    } on FirebaseAuthException catch (e) {
      logger.w("==============>>>>>${e.toString()}");
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<UserCredential?> loginInWithGoogle() async {

    try {
      final controller = await Get.put(UserRepository());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);
      // Access user data
      User? user = userCredential.user;

      print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      // logger.e(user);
      if (user != null) {
        final _user = UserModel(
          displayName: user.displayName ?? "",
          email: user.email ?? "",
          phoneNo: user.phoneNumber ?? "",
          photoURL: user.photoURL ?? "",
          uid: user.uid,
        );
        UserRepository.instance.createUser(_user);
        print("============================================================================");
        return userCredential;
      }
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      logger.w("Google Sign-In Error: ${error.toString()}");
      print("----------------------------------------------------------------------------");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    // await _googleSignIn.signOut();
    Get.offAllNamed('/login');
  }
}
