import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/views/authentication/auth_decider.dart';
import 'package:rrt_client_web_app/views/authentication/login.dart';
import 'package:rrt_client_web_app/views/authentication/register_account.dart';
import 'package:rrt_client_web_app/views/authentication/reset_password_link.dart';
import 'package:rrt_client_web_app/views/home/home_screen.dart';
import 'package:rrt_client_web_app/views/home/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RTT CLIENT APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home:RegisterAccount(),
        home: HomePage(),
      ),
      designSize: const Size(1920, 1080),
    );
  }
}
