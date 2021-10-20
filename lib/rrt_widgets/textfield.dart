import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_colors.dart';

Widget textformfield(
  TextEditingController? _controller,
  String hintText,
  //final VoidCallback,
  String labelText,
  bool obsecure,
  TextInputType type,
  //String? emptyValidationMessage,
  final validator

) {
  return TextFormField(
      autovalidate: true,
      validator: validator,
      //emptyValidationMessage,
      // validator: (value) {
      //   Pattern pattern =
      //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      //   RegExp regex = new RegExp(pattern as String);
      //   return (!regex.hasMatch(value!)) ? emptyValidationMessage : null;
      // },
      keyboardType: type,
      obscureText: obsecure,
      cursorColor: fLabelTextColor,
      controller: _controller,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(color: Color(0xFF797a7a)),
          labelStyle: const TextStyle(color: Color(0xff83b7b8)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sp),
            borderSide: const BorderSide(color: Color(0xff83b7b8)),
            gapPadding: 10.sp,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sp),
            borderSide: const BorderSide(color: Color(0xff83b7b8)),
            gapPadding: 10,
          )));
}

Widget textormfield(
  BuildContext context,
  String s, {
  IconData? icon,
  String? hintText,
  String? labelText,
  TextEditingController? controller,
  bool readOnly = false,
  String? emptyValidationMessage,
  TextInputType? inputType,
  int? lines,
  required bool obsecure,
  String? validaterMsg,
  Widget? suffixdata,
}) {
  return TextFormField(
      maxLines: lines,
      controller: controller,
      validator: (value) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern as String);
        return (!regex.hasMatch(value!)) ? emptyValidationMessage : null;
      },
      obscureText: obsecure,
      //style: mediumwhiteStyle,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(color: Color(0xFF797a7a)),
          labelStyle: const TextStyle(color: Color(0xff83b7b8)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sp),
            borderSide: const BorderSide(color: Color(0xff83b7b8)),
            gapPadding: 10.sp,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.sp),
            borderSide: const BorderSide(color: Color(0xff83b7b8)),
            gapPadding: 10,
          )));
}
