import 'package:expense_tracker/home_page.dart';
import 'package:expense_tracker/src/exceptions/platform_exceptions.dart';
import 'package:expense_tracker/src/features/authentication/screens/signup/verify_email.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../features/authentication/models/user_model.dart';
import '../../utils/logger/logger.dart';
import '../../features/authentication/screens/onboarding/onboarding.dart';
import '../../exceptions/firebase_auth_exceptions.dart';
import '../../exceptions/firebase_exceptions.dart';
import '../../exceptions/format_exceptions.dart';
import '../../features/authentication/screens/login/login_page.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();

    // firebaseUser = Rx<User?>(_auth.currentUser);
    // firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => HomePage());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => LoginPage())
          : Get.offAll(const OnBoardingScreen());
    }
  }

  // -----------------------------------------Email & Password sign-in----------------------------------------------

  ///[EmailAuthentication] - LOGIN
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TcFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TcFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TcFormatException();
    } on PlatformException catch (e) {
      throw TcPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TcFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TcFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TcFormatException();
    } on PlatformException catch (e) {
      throw TcPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailVerification] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TcFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TcFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TcFormatException();
    } on PlatformException catch (e) {
      throw TcPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Future<void> createUserWithEmailAndPassword(
  //     String email, String password) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     // firebaseUser.value != null
  //     //     ? Get.offAll(() => ('/home'))
  //     //     : Get.offAll(() => /*WelcomeScreen()*/ ('/login'));
  //     User? user = _auth.currentUser;
  //     logger.i("+++++++++++++>>>>>$user");
  //   } on FirebaseAuthException catch (e) {
  //     final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
  //     logger.w("===fffffff====>>>>>${ex.message}");
  //     Get.snackbar('Error', ex.message.toString(),
  //         snackPosition: SnackPosition.BOTTOM);
  //
  //     throw ex;
  //   } catch (_) {
  //     final ex = SignUpWithEmailAndPasswordFailure.code("");
  //     logger.w("===-------====>>>>>${ex.message}");
  //     Get.snackbar('Error', ex.message.toString(),
  //         snackPosition: SnackPosition.BOTTOM);
  //
  //     throw ex;
  //   }
  // }

  // Future<void> loginWithEmailAndPassword(String email, String password) async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
  //   }
  // }

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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Access user data
      User? user = userCredential.user;

      print(
          "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      // logger.e(user);
      if (user != null) {
        final _user = UserModel(
          displayName: user.displayName ?? "",
          email: user.email ?? "",
          phoneNo: user.phoneNumber ?? "",
          photoURL: user.photoURL ?? "",
          uid: user.uid,
        );
        // UserRepository.instance.createUser(_user);
        print(
            "============================================================================");
        return userCredential;
      }
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {
      print(
          "----------------------------------------------------------------------------");
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginPage());
    } on FirebaseAuthException catch (e) {
      throw TcFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TcFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw TcFormatException();
    } on PlatformException catch (e) {
      throw TcPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
