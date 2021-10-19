import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/rrt_Screens/home_screen.dart';
import 'package:rrt_client_web_app/rrt_Screens/register_account.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rrt_client_web_app/rrt_Screens/rrt_forgot_password_screen.dart';
import 'package:rrt_client_web_app/rrt_Screens/user_billing_information.dart';
import 'package:rrt_client_web_app/rrt_widgets/home_dashboard.dart';
import 'rrt_Screens/login.dart';

void main() {
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
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Login(),
      ),
      designSize: Size(1920, 1080),
    );
  }
}
