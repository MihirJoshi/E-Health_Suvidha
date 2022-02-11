import 'package:e_suvidha/pages/main_page.dart';
import 'package:e_suvidha/pages/p_login_page.dart';
import 'package:e_suvidha/pages/p_register_page.dart';
import 'package:e_suvidha/utils/routes.dart';
import 'package:e_suvidha/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(HealthSuvidha());
}

class HealthSuvidha extends StatelessWidget {
  const HealthSuvidha({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.mainPageRoute,
      routes: {
        MyRoutes.splashRoute: (context) => SplashScreen(),
        MyRoutes.mainPageRoute: (context) => Main_Page(),
        MyRoutes.ploginRoute: (context) => PLoginPage(),
        MyRoutes.pregisterRoute: (context) => PRegistration(),
      },
    );
  }
}
