import 'package:expense_tracker/src/feactures/authentication/screens/auth/registration_page.dart';
import 'package:expense_tracker/src/feactures/authentication/screens/profile_page.dart';
import 'package:expense_tracker/src/repository/authentication_repository/authentication_repository.dart';
import 'package:expense_tracker/src/utils/theme/theme.dart';
import 'package:expense_tracker/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'src/feactures/authentication/screens/auth/login_page.dart';
import 'firebase_options.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeUtils(context);
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: TcAppTheme.lightTheme,
      darkTheme: TcAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/registration', page: () => RegistrationPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
      ],
    );
  }
}
