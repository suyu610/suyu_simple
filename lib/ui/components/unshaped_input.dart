import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/constant/theme_color.dart';

class UnShapedInput extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextEditingController controller;
  static double s1 = new Random().nextDouble() * 60 + 10;
  static double s2 = new Random().nextDouble() * 60 + 10;
  static double s3 = new Random().nextDouble() * 60 + 10;
  static double s4 = new Random().nextDouble() * 60 + 10;
  static double s5 = new Random().nextDouble() * 60 + 10;
  static double s6 = new Random().nextDouble() * 60 + 10;
  static double s7 = new Random().nextDouble() * 60 + 10;
  static double s8 = new Random().nextDouble() * 60 + 10;

  const UnShapedInput({this.icon, this.controller, this.text, Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.w,
      padding: EdgeInsets.only(left: 10.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(s1, s2),
          topRight: Radius.elliptical(s3, s4),
          bottomRight: Radius.elliptical(s5, s6),
          bottomLeft: Radius.elliptical(s7, s8),
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.colorTheme,
            spreadRadius: 2.0,
            offset: Offset(3.0, 4.0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16.sp,
          ),
          SizedBox(
            width: 10.w,
          ),
          Container(
            height: 30.h,
            width: 280.w,
            child: TextFormField(
                controller: controller,
                style: TextStyle(color: Colors.white),
                maxLines: 1,
                cursorColor: Colors.white,
                cursorWidth: 2.w,
                cursorRadius: Radius.circular(2.w),
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    isDense: true,
                    hintText: text,
                    border: InputBorder.none)),
          ),
        ],
      ),
    );
  }
}
