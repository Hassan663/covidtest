import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrt_client_web_app/rrt_Screens/login.dart';
import 'package:rrt_client_web_app/rrt_Screens/rrt_forgot_password_screen.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_colors.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_sizes.dart';
import 'package:rrt_client_web_app/rrt_widgets/textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'user_billing_information.dart';

class RegisterAccount extends StatelessWidget {
  TextEditingController? fNameController = TextEditingController();
  TextEditingController? lNameController = TextEditingController();
  TextEditingController? emailController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: fBackgroundColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Container(
              height: height,
              width: width * 0.4,
              child: SingleChildScrollView(
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.h),
                        child: Image.asset("assets/rtt.png"),
                      ),
                      Text(
                        "Create Account",
                        style: GoogleFonts.openSans(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39.w),
                        child: textformfield(
                            fNameController,
                            'Enter first name',
                            'First Name',
                            
                            false,
                            TextInputType.name,
                            "Please fill this field",),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39.w),
                        child: textformfield(lNameController, 'Enter last name',
                            'Last Name', false, TextInputType.name,"Please fill this field",),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39.w),
                        child: textformfield(
                            emailController,
                            'Enter your email',
                            'Email',
                            false,
                            TextInputType.emailAddress,"Please fill this field",),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39.w),
                        child: textformfield(
                            passwordController,
                            'Enter Password',
                            'Password',
                            true,
                            TextInputType.name,"Please fill this field",),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39.w),
                        child: textformfield(
                            confirmpasswordController,
                            'Confirm Password',
                            'Confirm Password',
                            true,
                            TextInputType.name,"Please fill this field",),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Login());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0.w),
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                  color: Color(0xfffc6359),
                                  // fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(UserBillingInformation());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.2,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          decoration: BoxDecoration(
                              color: const Color(0xfffc6359),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(UserBillingInformation());
                      //   },
                      //   child: Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 120.w),
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       // height: 65.h,
                      //       width: width,
                      //       padding: EdgeInsets.symmetric(vertical: 15.0.h),
                      //       decoration: BoxDecoration(
                      //           color: Color(0xfffc6359),
                      //           borderRadius: BorderRadius.circular(30.0.sp)),
                      //       child: Text(
                      //         'Next',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
