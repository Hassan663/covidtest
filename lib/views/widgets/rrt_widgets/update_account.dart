// import 'package:flutter/material.dart';
// import 'package:rrt_client_web_app/constants/rrt_sizes.dart';

// class UpdateAccount extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           decoration: new BoxDecoration(
//               color: Color(0xffE5E5E5), //new Color.fromRGBO(255, 0, 0, 0.0),
//               borderRadius: new BorderRadius.only(
//                   topLeft:   Radius.circular(circular_radius_homeContainers),
//                   bottomLeft: Radius.circular(circular_radius_homeContainers))
//           ),
//           child: Center(child: Text('update account'),),
//         )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rrt_client_web_app/constants/custom_snackbar.dart';
import 'package:rrt_client_web_app/constants/rrt_colors.dart';
import 'package:rrt_client_web_app/constants/rtt_textstyle.dart';
import 'package:rrt_client_web_app/constants/utils/auth_exception_handler.dart';
import 'package:rrt_client_web_app/controllers/authentication/auth_controller.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/button.dart';
import 'package:rrt_client_web_app/views/widgets/rrt_widgets/textfield.dart';
import 'package:file_picker/file_picker.dart';

class UpdateAccount extends StatefulWidget {
  @override
  _UpdateAccountState createState() => _UpdateAccountState();
}

class _UpdateAccountState extends State<UpdateAccount> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool validateAndSaveUser() {
    final form = formkey.currentState;
    form!.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: fBackgroundColor,
        body: Padding(
          padding: EdgeInsets.only(top: 80.h),
          child: Center(
            child: Container(
              height: height,
              width: width * 0.4,
              child: SingleChildScrollView(
                child: Card(
                  shadowColor: Colors.grey,
                  elevation: 10,
                  color: Colors.white,
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 35.h),
                          child: Image.asset("assets/rtt.png"),
                        ),
                        Text("Update Account", style: TitleText),
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 39.w),
                          child: textformfield(
                            fNameController,
                            'Enter first name',
                            'First Name',
                            false,
                            TextInputType.name,
                            (value) {
                              return (value!.isEmpty)
                                  ? "First Name can't be Empty"
                                  : null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 39.w),
                          child: textformfield(
                            lNameController,
                            'Enter last name',
                            'Last Name',
                            false,
                            TextInputType.name,
                            (value) {
                              return (value!.isEmpty)
                                  ? "Last Name can't be Empity"
                                  : null;
                            },
                          ),
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
                            TextInputType.emailAddress,
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
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularButtons(
                              backgroundColor: const Color(0xff4F8484),
                              borderColor: const Color(0xff4F8484),
                              text: "Upload License",
                              height: 50,
                              width: width * 0.15,
                              textColor: Colors.white,
                              textStyle: WhiteText,
                              onPressed: () async {
                                final license =
                                    await FilePicker.platform.pickFiles();
                              },
                            ),
                            CircularButtons(
                              backgroundColor: const Color(0xff4F8484),
                              borderColor: const Color(0xff4F8484),
                              text: "Upload Passport",
                              height: 50,
                              width: width * 0.15,
                              textColor: Colors.white,
                              textStyle: WhiteText,
                              onPressed: ()async {
                                 final passport =
                                    await FilePicker.platform.pickFiles();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CircularButtons(
                            backgroundColor: const Color(0xfffc6359),
                            borderColor: const Color(0xfffc6359),
                            text: "Save",
                            height: 50,
                            width: width * 0.2,
                            textColor: Colors.white,
                            textStyle: WhiteText,
                            onPressed: () {
                              if (validateAndSaveUser()) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          backgroundColor: Colors.white,
                                          content: Container(
                                            height: 200,
                                            width: 400,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Do you want to update account',
                                                      style: TextStyle(
                                                          color: fButtonColor,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    CircularButtons(
                                                      backgroundColor:
                                                          const Color(
                                                              0xff4F8484),
                                                      borderColor: const Color(
                                                          0xff4F8484),
                                                      text: "Yes",
                                                      height: 50,
                                                      width: width * 0.1,
                                                      textColor: Colors.white,
                                                      textStyle: WhiteText,
                                                      onPressed: () {
                                                        CustomSnackBar.showSnackBar(
                                                            title:
                                                                "Account Updated Sucessfully",
                                                            message: '',
                                                            backgroundColor:
                                                                snackBarSuccess);
                                                      },
                                                    ),
                                                    CircularButtons(
                                                      backgroundColor:
                                                          const Color(
                                                              0xfffc6359),
                                                      borderColor: const Color(
                                                          0xfffc6359),
                                                      text: "No",
                                                      height: 50,
                                                      width: width * 0.1,
                                                      textColor: Colors.white,
                                                      textStyle: WhiteText,
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ));
                                    });
                              } else {
                                CustomSnackBar.showSnackBar(
                                    title: "Please Fill All Fields",
                                    message: '',
                                    backgroundColor: snackBarError);
                              }
                            }),
                        SizedBox(
                          height: 40.h,
                        )
                      ],
                    ),
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
