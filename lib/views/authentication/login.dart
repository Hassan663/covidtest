import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resize/resize.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/utils/auth_exception_handler.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/views/authentication/register_account.dart';
import 'package:rrt_client_web_app/views/authentication/reset_password_link.dart';
import 'package:rrt_client_web_app/views/authentication/rrt_forgot_password_screen.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/textfield.dart';

import '../home/home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void tryLogin() async {
    //Login user on auth request
    final status =
        await authController.loginUser(usernameController.text.trim(), passwordController.text);
    if (status == AuthResultStatus.successful) {
      Get.off(HomePage());
      CustomSnackBar.showSnackBar(
          title: "Login Successful",
          message: '',
          backgroundColor: snackBarSuccess);
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      CustomSnackBar.showSnackBar(
          title: errorMsg, message: '', backgroundColor: snackBarError);
    }
  }


  void validate() {
    if (formkey.currentState!.validate()) {
      debugPrint("Validated");
    } else {
      debugPrint("object");
    }
  }



  late String _passwordError;
  bool validateAndSave() {
    final form = formkey.currentState;
    form!.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  _validateAndSubmitSignIn(context) async {
    if (validateAndSave()) {
    } else {
      debugPrint("Please fill all fields".toUpperCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor:const Color(0xffE5E5E5),
        body: Center(
          child: Container(
            height: height * 0.75,
            width: width * 0.4,
            child: SingleChildScrollView(
              child: Card(
                shadowColor: Colors.grey,
                elevation: 10,
                color: Colors.white,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset("assets/rtt.png"),
                      ),
                      Text(
                        "Log In",
                        style: GoogleFonts.openSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 39),
                        child: textformfield(
                          usernameController,
                          'Enter username',
                          'Username',
                          false,
                          TextInputType.name,
                          (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = RegExp(pattern as String);
                            return (!regex.hasMatch(value!))
                                ? "Please Enter Valid Email"
                                : null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 39),
                        child: textformfield(
                          passwordController,
                          'Enter password',
                          'Password',
                          true,
                          TextInputType.name,
                          (value) {
                            return (value!.isEmpty)
                                ? "Password can't be Empty"
                                : null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(RegisterAccount());
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
                              Get.to(ResetPasswordLink());
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
                      const SizedBox(
                        height: 20,
                      ),

                      CircularButtons(
                        backgroundColor: const Color(0xfffc6359),
                        borderColor: const Color(0xfffc6359),
                        text: "Log In",
                        height: 50,
                        width: width * 0.2,
                        onPressed: () {
                          setState(() {
                            if (usernameController.text.endsWith(".com") ==
                                    false ||
                                passwordController.text.isEmpty) {
                              _passwordError = "This field is required*";
                            } else{
                              tryLogin();
                            }
                          });
                        },
                        textColor: Colors.white,
                        textStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(
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
// InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         if (usernameController!.text.endsWith(".com") ==
                      //                 false ||
                      //             passwordController!.text.length < 1) {
                      //           _passwordError = "This field is required*";
                      //           print("ok");
                      //         } else
                      //           Get.to(HomePage());
                      //       });
                      //     },
                      // Container(
                      //   alignment: Alignment.center,
                      //   width: MediaQuery.of(context).size.width * 0.2,
                      //   padding: const EdgeInsets.symmetric(vertical: 15.0),
                      //   decoration: BoxDecoration(
                      //       color: const Color(0xfffc6359),
                      //       borderRadius: BorderRadius.circular(30.0)),
                      //   child: const Text(
                      //     'Log In',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      //),