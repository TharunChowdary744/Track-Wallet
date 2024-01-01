import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'auth_controller.dart';

class RegistrationPage extends StatelessWidget {
  // final AuthController _authController = Get.find();
  final AuthController _authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
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
                await _authController.signUpWithEmailAndPassword(emailController.text, passwordController.text);
                if (_authController.user.value != null) {
                  // Navigate to the home page or do something else after successful registration
                  Get.offAllNamed('/home');
                }
              },
              child: Text('Sign Up with Email/Password'),
            ),
          ],
        ),
      ),
    );
  }
}