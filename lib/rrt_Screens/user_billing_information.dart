import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_sizes.dart';
import 'package:rrt_client_web_app/rrt_widgets/textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login.dart';

class UserBillingInformation extends StatelessWidget {
  TextEditingController? cardNumberController = TextEditingController();
  TextEditingController? cardHolderNameController = TextEditingController();
  TextEditingController? cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 100.h, bottom: 50.h),
            child: Container(
              height: height,
              width: width * 0.4,
              child: Card(
                shadowColor: Colors.grey,
                elevation: 10,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Image.asset("assets/rtt.png"),
                    ),
                    Text(
                      "Create Account",
                      style: GoogleFonts.openSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0.h),
                      child: Text(
                        'Billing Information',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39.w),
                      child: textformfield(
                          cardNumberController,
                          'Enter card number',
                          'Card Number',
                          false,
                          TextInputType.number,"Please fill this field",),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39.w),
                      child: textformfield(
                          cardHolderNameController,
                          'Enter card holder name',
                          'Card Holder Name',
                          false,
                          TextInputType.name,"Please fill this field",),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 39.w),
                      child: textformfield(cvvController, 'Enter Cvv', 'Cvv',
                          false, TextInputType.number,"Please fill this field",),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                  padding:
                                      EdgeInsets.symmetric(vertical: 15.0.h),
                                  child: const Text(
                                    "Log In",
                                    style: TextStyle(
                                      color: Color(0xfffc6359),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 30.w),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/paypal.png",
                                      height: 40,
                                      width: 40,
                                    ),
                                    Image.asset(
                                      "assets/mastercard1.png",
                                      height: 50,
                                      width: 50,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.2,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                            color: const Color(0xfffc6359),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
