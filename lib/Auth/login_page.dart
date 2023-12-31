import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  // final AuthController _authController = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _authController.signInWithEmailAndPassword(emailController.text, passwordController.text);
                // await _authController.signInWithEmailAndPassword(emailController.text, passwordController.text);
                if (_authController.user.value != null) {
                  print("------------------->>>>>${_authController.user}");

                  // Navigate to the home page or do something else after successful login
                  Get.offAllNamed('/home');
                }
              },
              child: Text('Sign In with Email/Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _authController.signInWithGoogle();
                if (_authController.user.value != null) {
                  print("------------------->>>>>${_authController.user}");
                  // Navigate to the home page or do something else after successful login
                  Get.offAllNamed('/home');
                }
              },
              child: Text('Sign In with Google'),
            ),
          ],
        ),
      ),
    );
  }
}