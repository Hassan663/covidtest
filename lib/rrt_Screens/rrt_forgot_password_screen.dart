import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrt_client_web_app/rrt_Screens/home_screen.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_sizes.dart';
import 'package:rrt_client_web_app/rrt_widgets/textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffE5E5E5),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              height: height * 0.7,
              width: width*0.4,
              child: Card(
                shadowColor: Colors.grey,
                elevation: 10,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Image.asset("assets/rtt.png"),
                    ),
                    Text(
                      "Forgot Password",
                      style: GoogleFonts.openSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39.w),
                      child: textformfield(
                          passwordController, 'Enter username', 'Username',false,TextInputType.name,"Please fill this field",),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39.w),
                      child: textformfield(confirmpasswordController,
                          'Enter password', 'Confirm Password',false,TextInputType.name,"Please fill this field",),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    // InkWell(
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     width: MediaQuery.of(context).size.width * 0.2,
                    //     padding: EdgeInsets.symmetric(vertical: 20.0.h),
                    //     decoration: BoxDecoration(
                    //         color: Color(0xfffc6359),
                    //         borderRadius: BorderRadius.circular(30.0)),
                    //     child: const Text(
                    //       'Log In',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // )
                    InkWell(
                      onTap: () {
                        // Get.to(Login());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.2,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                            color: const Color(0xfffc6359),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: const Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
