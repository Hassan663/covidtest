import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resize/resize.dart';
import 'package:rrt_client_web_app/rrt_Screens/home_screen.dart';
import 'package:rrt_client_web_app/rrt_Screens/register_account.dart';
import 'package:rrt_client_web_app/rrt_Screens/rrt_forgot_password_screen.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_sizes.dart';
import 'package:rrt_client_web_app/rrt_widgets/textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate() {
    if (formkey.currentState!.validate()) {
      print("Validated");
    } else {
      print("object");
    }
  }

  TextEditingController? usernameController = TextEditingController();

  TextEditingController? passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        body: Center(
          child: Container(
            height: height * 0.7,
            width: width * 0.4,
            child: SingleChildScrollView(
              child: Card(
                shadowColor: Colors.grey,
                elevation: 10,
                color: Colors.white,
                child: Form(
                  autovalidate: true,
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset("assets/rtt.png"),
                      ),

                      Text(
                        "Log In",
                        style: GoogleFonts.openSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39),
                        child: textformfield(
                            usernameController,
                            'Enter username',
                            'Username',
                            false,
                            TextInputType.name,
                            "Please fill this field"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39),
                        child: textformfield(
                            passwordController,
                            'Enter password',
                            'Password',
                            true,
                            TextInputType.name,
                            "Please fill this field"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              validate;
                                if (formkey.currentState!.validate()) {
                                  Get.to(RegisterAccount());
                                } 
                                  
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const Text(
                                "Create Account.",
                                style: TextStyle(
                                  color: Color(0xfffc6359),
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 5,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Forgot your password? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(ForgotPassword());
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: const Text(
                                "Reset password.",
                                style: TextStyle(
                                  color: Color(0xfffc6359),
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          validate();
                          Get.to(HomePage());
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
      ),
    );
  }
}
