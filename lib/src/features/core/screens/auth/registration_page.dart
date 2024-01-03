import 'package:expense_tracker/src/utils/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common_widgets/blueButton.dart';
import '../../../../common_widgets/form_fields/custom_form_field.dart';
import '../../../../utils/utils.dart';
import '../../../../common_widgets/googleButton.dart';
import '../../controllers/auth_controllers/login_controller.dart';
import '../../controllers/auth_controllers/signup_controller.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _emailNode = FocusNode();
    final _passwordNode = FocusNode();

    void _onSignInPressed() {
      Navigator.of(context).pushReplacementNamed('/login');
    }

    final controller = Get.put(SignUpController());
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
                  "Sign Up",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        fontSize: screenHeight * 0.042249047, //38
                      ),
                ),
                SizedBox(
                  height: screenHeight * 0.036689962, //33
                ),
                Form(
                  key: controller.signupFormKey,
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
                        validator: (value) => TcValidator.validateEmail(value),
                        obscureText: false,
                      ),
                      SizedBox(height: screenHeight * 0.024459975), // 22
                      Obx(
                        () => CustomTextFormField(
                          currentNode: _passwordNode,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          fieldController: controller.password,
                          hintText: 'Password',
                          prefixImage: 'assets/icons/auth_icons/lock.svg',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              TcValidator.validatePassword(value),
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
                      // SizedBox(height: screenHeight * 0.061149936), // 55
                      SizedBox(height: screenHeight * 0.024459975), // 22
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => Checkbox(
                              value: controller.privacyPolicy.value,
                              onChanged: (value) => controller.privacyPolicy
                                  .value = !controller.privacyPolicy.value,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                          Text(
                            "I accept ",
                            style:
                                Theme.of(context).textTheme.headline3?.copyWith(
                                      fontSize: screenHeight * 0.01111817, // 10
                                    ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              launch("https://contri-app.web.app");
                            },
                            child: Text(
                              "Terms and Conditions",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    fontSize: screenHeight * 0.01111817, // 10
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.024459975), // 22
                      BlueButton(
                          title: "Sign Up",
                          onPressed: () => controller.registerUser()),
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
                      "or register with",
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
                  title: "Sign Up with Google",
                  onPressed: () {
                    // SignUpController.instance.registerUser(_emailTextController.text, _passtextController.text);
                    LoginController.instance.googleLogin();
                  },
                ),
                SizedBox(height: screenHeight * 0.140462516),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            fontSize: screenHeight * 0.01111817, // 10
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    GestureDetector(
                      onTap: _onSignInPressed,
                      child: Text(
                        "Sign In",
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