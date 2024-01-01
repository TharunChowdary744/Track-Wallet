import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import '../ui/components/blueButton.dart';
import '../ui/components/customFormField.dart';
import '../ui/components/googleButton.dart';
import '../ui/themes/utils.dart';
import '../ui/themes/validators.dart';

class LoginPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    void _onSignUpPressed() {
      // Navigator.of(context).pushReplacementNamed("/registration");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
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
                LoginForm(),
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
                    onPressed:(){} //_onGoogleSignInPressed,
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
      ),
    );
  }
}
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _validator = Validator();
  bool _isObscure = true;
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Future<void> _onLoginButtonPressed() async {
    if (!_formKey.currentState!.validate()) return;
    await _authController.signInWithEmailAndPassword(emailController.text, passwordController.text);
    // await _authController.signInWithEmailAndPassword(emailController.text, passwordController.text);
    if (_authController.user.value != null) {
      print("------------------->>>>>${_authController.user}");
      // Navigate to the home page or do something else after successful login
      Get.offAllNamed('/home');
    }
    // Provider.of<LoginProvider>(context, listen: false).setLoading(true);
    // try {
    //   AuthService authService = AuthService();
    //   await authService.signInWithEmailAndPassword(
    //     email: _emailTextController.text,
    //     password: _passtextController.text,
    //   );
    //   /// Initialize some data or perform additional logic
    //   await initializeSdk;
    //   logger.i("sdk Initialized");
    //
    //   /// Check if the user profile is complete
    //   if (globalUser.registrationStatus != RegistrationStatus.registered.toString()) {
    //     logger.i("User Profile Incomplete");
    //     Provider.of<LoginProvider>(context, listen: false).setLoading(false);
    //     // Navigator.of(context).pushReplacementNamed(ProfileRegPage.id);
    //   }
    //   else {
    //     logger.i("All Checks Passed");
    //
    //     ///Upload device token for notifications
    //     final _prefs = await SharedPreferences.getInstance();
    //     final _notificationStatus = _prefs.getBool('showNotifications');
    //     logger.v("Show Notifications: $_notificationStatus");
    //
    //     if (_notificationStatus == null || _notificationStatus == true) {
    //       await NotificationHandler.uploadDeviceToken(userId: globalUser.id);
    //     }
    //
    //     /// Initialize comments
    //     // await initializeComments;
    //
    //     // Example 5: Navigate to the success screen or perform other actions
    //     Provider.of<LoginProvider>(context, listen: false).setLoading(false);
    //     Navigator.of(context).pushReplacementNamed(HomePage.id);
    //   }
    //
    // } catch (e) {
    //   Provider.of<LoginProvider>(context, listen: false).setLoading(false);
    //   // Handle login failure
    //   context.showSnackBar("Login failed: $e");
    // }

  }

  void _onForgetPasswordPressed() {
    final _emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    // showDialog(
    //   context: context,
    //   builder: (dialogContext) => PassResetMailDialog(
    //     formKey: _formKey,
    //     emailController: _emailController,
    //     onPressed: () {
    //       if (!_formKey.currentState!.validate()) return;
    //
    //       BlocProvider.of<LoginBloc>(context)
    //           .add(ForgetPassword(email: _emailController.text));
    //     },
    //   ),
    // );
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
            fieldController: emailController,
            hintText: 'Email',
            prefixImage: 'assets/icons/auth_icons/mail.svg',
            keyboardType: TextInputType.emailAddress,
            validator: _validator.validateEmail, obscureText: false, enabled: mounted, suffix: _showPassIcon(), textCapitalization: TextCapitalization.none, inputFormatters: [],
          ),
          SizedBox(height: screenHeight * 0.024459975), // 22
          CustomTextFormField(
            currentNode: _passwordNode,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            fieldController: passwordController,
            hintText: 'Password',
            prefixImage: 'assets/icons/auth_icons/lock.svg',
            keyboardType: TextInputType.text,
            validator: _validator.validatePassword,
            obscureText: _isObscure,
            suffix: _showPassIcon(), nextNode: _emailNode, enabled: mounted,inputFormatters: [],textCapitalization: TextCapitalization.none,
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
          BlueButton(title: "Sign In", onPressed: _onLoginButtonPressed),
        ],
      ),
    );
  }
}