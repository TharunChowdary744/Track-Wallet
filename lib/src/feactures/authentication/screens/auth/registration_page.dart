import 'package:expense_tracker/glober/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common_widgets/blueButton.dart';
import '../../../../utils/utils.dart';
import '../../../../../ui/themes/validators.dart';
import '../../../../common_widgets/customFormField.dart';
import '../../../../common_widgets/googleButton.dart';
import '../../../../repository/user_repository/user_repository.dart';
import '../../controllers/auth_controllers/login_controller.dart';
import '../../controllers/auth_controllers/signup_controller.dart';
import '../../models/user_model.dart';

class RegistrationPage extends StatelessWidget {
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

    final controller = Get.put(SignUpController());
    final logincontroller = Get.put(LoginController());
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .caption
                        ?.copyWith(
                      fontSize: screenHeight * 0.01111817, // 10
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onSignInPressed,
                    child: Text(
                      "Sign In",
                      style:
                      Theme
                          .of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(
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

  void _onClickSignUp() {
    if (_formKey.currentState!.validate()) {
      SignUpController.instance.registerUser(_emailTextController.text, _passtextController.text);
      final user = UserModel(email: _emailTextController.text, password: _passtextController.text);
      UserRepository.instance.createUser(user);

    }else{
      logger.e(_emailTextController.text + _passtextController.text);
    };
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
            color: Theme
                .of(context)
                .primaryColor,
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
            validator: _validator.validateEmail,
            obscureText: false,
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(
                  fontSize: screenHeight * 0.01111817, // 10
                ),
              ),
              GestureDetector(
                onTap: () async {
                  launch("https://contri-app.web.app");
                },
                child: Text(
                  "Terms and Conditions",
                  style: Theme
                      .of(context)
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
          BlueButton(title: "Sign Up", onPressed: () {
            _onClickSignUp();
          }
          ),
        ],
      ),
    );
  }
}
