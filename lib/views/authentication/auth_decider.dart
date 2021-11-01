import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/views/authentication/login.dart';
import 'package:rrt_client_web_app/views/rrt_Screens/home_screen.dart';

class AuthDecider extends StatelessWidget {
  AuthDecider({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authController.getUserId(),
        builder: (ctx, AsyncSnapshot auth){
          if(auth.hasData && auth.data != null){
            authController.getUserById(auth.data);
            return HomePage();
          }else{
            return Login();
          }
        });
  }
}