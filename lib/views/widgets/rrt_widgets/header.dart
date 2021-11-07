import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Client!',
                style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 25.sp),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text('Have a nice day ahead.'),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.person)),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_none_outlined)),
                  IconButton(
                      onPressed: () {
                        authController.logOut();
                      },
                      icon: Icon(Icons.power_settings_new)),
                ],
              )
            ],
          )
        ],
      )
    ]);
  }
}
