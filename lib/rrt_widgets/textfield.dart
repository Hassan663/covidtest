import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rrt_client_web_app/rrt_widgets/rrt_colors.dart';

Widget textformfield(
  TextEditingController? _controller,
  String hintText,
  String labelText,
  bool obsecure,
  TextInputType type,
) {
  return TextFormField(
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
