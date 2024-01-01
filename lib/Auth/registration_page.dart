// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import 'auth_controller.dart';
//
// class RegistrationPage extends StatelessWidget {
//   // final AuthController _authController = Get.find();
//   final AuthController _authController = Get.put(AuthController());
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Registration'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: InputDecoration(labelText: 'Password'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await _authController.signUpWithEmailAndPassword(emailController.text, passwordController.text);
//                 if (_authController.user.value != null) {
//                   // Navigate to the home page or do something else after successful registration
//                   Get.offAllNamed('/home');
//                 }
//               },
//               child: Text('Sign Up with Email/Password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../ui/components/blueButton.dart';
import '../ui/components/customFormField.dart';
import '../ui/components/googleButton.dart';
import '../ui/themes/utils.dart';
import '../ui/themes/validators.dart';

class RegistrationPage extends StatelessWidget {
  // static const String id = 'register_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterMainBody()
    );
  }
}

class RegisterMainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _onGoogleSignUpPressed() {
      // if (!_RegisterFormState.acceptTnC) {
      //   context.showSnackBar("Please accept Terms and Conditions");
      //   return;
      // }
      //
      // BlocProvider.of<RegisterBloc>(context).add(GoogleSignUpClicked());
    }

    void _onSignInPressed() {
      Navigator.of(context).pushReplacementNamed('/login');
    }


          return ListView(
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
                    RegisterForm(),
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
                      onPressed: _onGoogleSignUpPressed,
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
                            style:
                            Theme.of(context).textTheme.headline6?.copyWith(
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
          );

  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailTextController = TextEditingController();
  final _passtextController = TextEditingController();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validator = Validator();
  static bool acceptTnC = false;
  bool _isObscure = true;

  void _onRegisterButtonPressed() {
    if (!_formKey.currentState!.validate()) return;

    // if (!acceptTnC) {
    //   context.showSnackBar("Please accept Terms and Conditions");
    //   return;
    // }
    //
    // BlocProvider.of<RegisterBloc>(context).add(RegisterButtonClicked(
    //     email: _emailTextController.text, password: _passtextController.text));
  }

  @override
  Widget build(BuildContext context) {
    Widget _showPassIcon() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: IconButton(
          icon: SvgPicture.asset(
            _isObscure
                ? "assets/icons/auth_icons/visibility_off.svg"
                : "assets/icons/auth_icons/visibility.svg",
            color: Theme.of(context).primaryColor,
            height: screenHeight * 0.024471635,
            width: screenHeight * 0.024471635,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextFormField(
            currentNode: _emailNode,
            nextNode: _passwordNode,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            fieldController: _emailTextController,
            hintText: 'Email',
            prefixImage: 'assets/icons/auth_icons/mail.svg',
            keyboardType: TextInputType.emailAddress,
            validator: _validator.validateEmail, obscureText: false,
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            currentNode: _passwordNode,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            fieldController: _passtextController,
            hintText: 'Password',
            prefixImage: 'assets/icons/auth_icons/lock.svg',
            keyboardType: TextInputType.text,
            validator: _validator.validatePassword,
            obscureText: _isObscure,
            suffix: _showPassIcon(),
          ),
          // SizedBox(height: screenHeight * 0.061149936), // 55
          SizedBox(height: screenHeight * 0.024459975), // 22
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                value: acceptTnC,
                onChanged: (newVal) {
                  setState(() {
                    acceptTnC = newVal!;
                  });
                },
                visualDensity: VisualDensity.compact,
              ),
              Text(
                "I accept ",
                style: Theme.of(context).textTheme.headline3?.copyWith(
                  fontSize: screenHeight * 0.01111817, // 10
                ),
              ),
              GestureDetector(
                onTap: () async {
                  launch("https://contri-app.web.app");
                },
                child: Text(
                  "Terms and Conditions",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontSize: screenHeight * 0.01111817, // 10
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          BlueButton(title: "Sign Up", onPressed: _onRegisterButtonPressed),
        ],
      ),
    );
  }
}
