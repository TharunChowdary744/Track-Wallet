import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("+++++++++++++>>>>>${_auth.currentUser}");

    } catch (e) {
      print("==============>>>>>${e.toString()}");

      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("+++++++++++++>>>>>${_auth.currentUser}");

    } catch (e) {
      print("==============>>>>>${e.toString()}");
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     await _auth.signInWithCredential(credential);
  //     print("+++++++++++++>>>>>${_auth.currentUser}");
  //
  //   } catch (e) {
  //     print("==============>>>>>${e.toString()}");
  //
  //     Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
  //   }
  // }
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _auth.signInWithCredential(credential);

        // Log the login event
        // await _analytics.logLogin(loginMethod: "google_signin");

        // Check if the user profile is complete
        // await checkProfileCompletion();
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
      // Handle the error
    }
  }

  // Future<void> checkProfileCompletion() async {
  //   if (currentUser.value != null) {
  //     final QuerySnapshot querySnapshot = await _firestore
  //         .collection('users')
  //         .where('email', isEqualTo: currentUser.value!.email)
  //         .get();
  //
  //     final List<DocumentSnapshot> documents = querySnapshot.docs;
  //
  //     if (documents.isEmpty) {
  //       // User profile is not complete, handle accordingly
  //       print("User profile is not complete.");
  //     } else {
  //       // User profile is complete, navigate to the next screen or perform actions
  //       print("User profile is complete.");
  //     }
  //   }
  // }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Get.offAllNamed('/login');
  }
}
