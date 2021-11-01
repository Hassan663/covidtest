import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/textfield.dart';

import 'home_screen.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController? passwordController = TextEditingController();

  TextEditingController? confirmpasswordController = TextEditingController();

  late String _passwordError;

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
              width: width * 0.4,
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
                        passwordController,
                        'Enter username',
                        'Username',
                        false,
                        TextInputType.name,
                        (value) {
                          return (value!.isEmpty)
                              ? "Username can't be Empity"
                              : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39.w),
                      child: textformfield(
                        confirmpasswordController,
                        'Enter password',
                        'Confirm Password',
                        true,
                        TextInputType.name,
                        (value) {
                          return (value!.isEmpty)
                              ? "Password can't be Empity"
                              : null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    CircularButtons(
                        backgroundColor: const Color(0xfffc6359),
                        borderColor: const Color(0xfffc6359),
                        text: "Login",
                        height: 50,
                        width: width * 0.2,
                        textColor: Colors.white,
                        textStyle: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                        onPressed: () {
                          if (passwordController!.text.length < 5 ||
                              confirmpasswordController!.text.length < 5) {
                            _passwordError = "Enter atleast";
                          } else {
                            Get.to(HomePage());
                          }
                          ;
                        }),
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
// InkWell(
                    //   onTap: () {
                    //     if (passwordController!.text.length < 5 ||
                    //         confirmpasswordController!.text.length < 5) {
                    //       _passwordError = "Enter atleast";
                    //     } else {
                    //       Get.to(HomePage());
                    //     }
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     width: MediaQuery.of(context).size.width * 0.2,
                    //     padding: const EdgeInsets.symmetric(vertical: 15.0),
                    //     decoration: BoxDecoration(
                    //         color: const Color(0xfffc6359),
                    //         borderRadius: BorderRadius.circular(30.0)),
                    //     child: const Text(
                    //       'Log In',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // ),


