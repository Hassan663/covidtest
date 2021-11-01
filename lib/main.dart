import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/views/rrt_Screens/login.dart';

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
          primarySwatch: Colors.blue,
        ),
        home: Login(),
      ),
      designSize: const Size(1920, 1080),
    );
  }
}
