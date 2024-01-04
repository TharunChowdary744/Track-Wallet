import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common/blueButton.dart';
import '../../../../common/forgotPasswordDialog.dart';
import '../../../../common/form_fields/custom_form_field.dart';
import '../../../../common/googleButton.dart';
import '../../../../utils/utils.dart';
import '../../../../utils/validators/validators.dart';
import '../../controllers/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _onSignUpPressed() {
      Navigator.of(context).pushReplacementNamed("/registration");
    }
    final _emailNode = FocusNode();
    final _passwordNode = FocusNode();

    void _onForgetPasswordPressed() {
      final _emailController = TextEditingController();
      // final _formKey = GlobalKey<FormState>();
      // showDialog(
      //   context: context,
      //   builder: (dialogContext) => PassResetMailDialog(
      //     formKey: _formKey,
      //     emailController: _emailController,
      //     onPressed: () {
      //       if (!_formKey.currentState!.validate()) return;
      //
      //       /// ////////////////////////////////////////////////////////////////////////////////////////
      //     },
      //   ),
      // );
    }

    final controller = Get.put(LoginController());
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: screenHeight * 0.142312579, // 128
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.072916667), // 30
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: screenHeight * 0.042249047, //38
                      ),
                ),
                SizedBox(
                  height: screenHeight * 0.036689962, //33
                ),
                Form(
                  key: controller.loginFormKey ,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(
                        currentNode: _emailNode,
                        nextNode: _passwordNode,
                        textInputAction: TextInputAction.next,
                        maxLines: 1,
                        fieldController: controller.email,
                        hintText: 'Email',
                        prefixImage: 'assets/icons/auth_icons/mail.svg',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value)=>TcValidator.validateEmail(value!),
                      ),
                      SizedBox(height: screenHeight * 0.024459975), // 22
                      Obx(
                        ()=> CustomTextFormField(
                          currentNode: _passwordNode,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          fieldController: controller.password,
                          hintText: 'Password',
                          prefixImage: 'assets/icons/auth_icons/lock.svg',
                          keyboardType: TextInputType.text,
                          validator: (value)=>TcValidator.validatePassword(value!),
                          obscureText: controller.hidePassword.value,
                          suffix: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                controller.hidePassword.value
                                    ? "assets/icons/auth_icons/visibility_off.svg"
                                    : "assets/icons/auth_icons/visibility.svg",
                                color: Theme.of(context).primaryColor,
                                height: screenHeight * 0.024471635,
                                width: screenHeight * 0.024471635,
                              ),
                              onPressed: () => controller.hidePassword.value =
                              !controller.hidePassword.value,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.024459975), // 22
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: _onForgetPasswordPressed,
                            child: Text(
                              "FORGOT PASWWORD",
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                fontSize: screenHeight * 0.01111817, // 10
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.024459975), // 22
                      BlueButton(
                          title: "Sign In",
                          onPressed: () {
                            // LoginController.instance.emailAndPasswordLogin(emailController.text, passwordController.text);
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.053367217, // 48
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "or connect with",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: screenHeight * 0.01111817, // 10
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.053367217, // 48
                ),
                GoogleButton(
                    title: "Continue with Google",
                    onPressed: () {
                      LoginController.instance.googleLogin();
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                    //_onGoogleSignInPressed,
                    ),
                SizedBox(height: screenHeight * 0.180462516), // 183
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontSize: screenHeight * 0.01111817, // 10
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    GestureDetector(
                      onTap: _onSignUpPressed,
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              fontSize: screenHeight * 0.01111817, // 10
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

