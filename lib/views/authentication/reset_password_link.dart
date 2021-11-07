import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resize/resize.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/rtt_textstyle.dart';
import 'package:rrt_client_web_app/constants/utils/auth_exception_handler.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/views/authentication/login.dart';
import 'package:rrt_client_web_app/views/authentication/register_account.dart';
import 'package:rrt_client_web_app/views/authentication/rrt_forgot_password_screen.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/textfield.dart';

import '../home/home_screen.dart';

class ResetPasswordLink extends StatefulWidget {
  @override
  _ResetPasswordLinkState createState() => _ResetPasswordLinkState();
}

class _ResetPasswordLinkState extends State<ResetPasswordLink> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();
  final emailController = TextEditingController();
  late String _email;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
        backgroundColor: const Color(0xffE5E5E5),
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
                        "Reset Password",
                        style: GoogleFonts.openSans(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "A link will be sent to your email address from where you can reset \n your password",
                          style: GreyText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 39),
                        child: textformfield(
                          emailController,
                          'Enter email',
                          'Email',
                          false,
                          TextInputType.name,
                          (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern as String);
                            return (!regex.hasMatch(value!))
                                ? "Please Enter Valid Email"
                                : null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //   height: 5,
                      // ),

                      CircularButtons(
                        backgroundColor: const Color(0xfffc6359),
                        borderColor: const Color(0xfffc6359),
                        text: "Send Link",
                        height: 50,
                        width: width * 0.2,
                        onPressed: () {
                          setState(() {
                            if (validateAndSave()) {
                              _firebaseAuth.sendPasswordResetEmail(
                                email: emailController.text,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "THE RESET LINK HAS BEEN SENT TO EMAIL PROVIDED"),
                                duration: Duration(seconds: 5),

                              ));
                              Get.to(Login());
                            } else {}
                            print("object");
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

// class Forget extends StatefulWidget {
//   @override
//   _ForgetState createState() => _ForgetState();
// }

// class _ForgetState extends State<Forget> {
//   final TextEditingController emailController = TextEditingController();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   late String _email;
//   @override
//   Widget build(BuildContext context) {
//     //final validationService = Provider.of<SignupValidation>(context);

//     return Scaffold(
//         body: Container(
//       child: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(16),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.fromLTRB(10.0, 50.0, 0.0, 30.0),
//                 child: Text(
//                   "Forgot Password",
//                   style: TextStyle(
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.indigo,
//                     fontStyle: FontStyle.normal,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0),
//                 child: Text(
//                   "Enter your correct email we will send you reset password link :)",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.fromLTRB(0.0, 0.0, 320.0, 0.0),
//                 child: Text(
//                   "Email",
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.w900,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               TextField(
//                 onChanged: (String value) {
//                   //validationService.changeEmail(value);
//                   _email = value;
//                 },
//                 cursorColor: Colors.black,
//                 style: TextStyle(
//                     fontWeight: FontWeight.w900,
//                     color: Colors.grey[700],
//                     fontSize: 20.0,
//                     fontStyle: FontStyle.normal),
//                 controller: emailController,
//                 decoration: InputDecoration(
//                     //errorText: validationService.email.error,
//                     hintText: "Enter Email",
//                     hintStyle: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         color: Colors.grey[700],
//                         fontSize: 20.0,
//                         fontStyle: FontStyle.normal),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.indigoAccent),
//                         borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                     filled: true,
//                     prefixIcon: Icon(
//                       Icons.email,
//                       color: Colors.indigo,
//                     )),
//               ),
//               SizedBox(height: 20.0),
//               Container(
//                   padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 0.0),
//                   height: 40.0,
//                   child: Material(
//                     borderRadius: BorderRadius.circular(30.0),
//                     shadowColor: Colors.indigo,
//                     elevation: 17.0,
//                     color: Colors.grey,
//                     child: GestureDetector(
//                       onTap: () {
//                         _firebaseAuth.sendPasswordResetEmail(email: _email);
//                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                           content: Text(
//                               "THE RESET LINK HAS BEEN SENT TO EMAIL PROVIDED"),
//                           duration: Duration(seconds: 5),
//                         ));
//                       },
//                       child: Center(
//                         child: Text(
//                           "Submit",
//                           style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                               fontFamily: "Monstserrat",
//                               color: Colors.black),
//                         ),
//                       ),
//                     ),
//                   )),
//               SizedBox(
//                 height: 16,
//               ),
//               //SizedBox(height: 20.0),
              
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
