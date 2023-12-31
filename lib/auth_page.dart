import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class AuthPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _authController.signUpWithEmailAndPassword('email@example.com', 'password');
              },
              child: Text('Sign Up with Email/Password'),
            ),
            ElevatedButton(
              onPressed: () {
                _authController.signInWithEmailAndPassword('email@example.com', 'password');
              },
              child: Text('Sign In with Email/Password'),
            ),
            ElevatedButton(
              onPressed: () {
                _authController.signInWithGoogle();
              },
              child: Text('Sign In with Google'),
            ),
            ElevatedButton(
              onPressed: () {
                _authController.signOut();
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
//
// void main() {
//   runApp(GetMaterialApp(
//     home: AuthPage(),
//   ));
// }
