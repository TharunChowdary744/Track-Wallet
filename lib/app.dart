import 'package:expense_tracker/src/bindings/general_bindings.dart';
import 'package:expense_tracker/src/features/authentication/screens/login/login_page.dart';
import 'package:expense_tracker/src/features/authentication/screens/onboarding/onboarding.dart';
import 'package:expense_tracker/src/features/authentication/screens/signup/registration_page.dart';
import 'package:expense_tracker/src/features/core/screens/profile_page.dart';
import 'package:expense_tracker/src/utils/constants/colors.dart';
import 'package:expense_tracker/src/utils/theme/theme.dart';
import 'package:expense_tracker/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeUtils(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TcAppTheme.lightTheme,
      darkTheme: TcAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: GeneralBindings(),
      home: Scaffold(
        backgroundColor: TcColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/registration', page: () => RegistrationPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
      ],
    );
  }
}
