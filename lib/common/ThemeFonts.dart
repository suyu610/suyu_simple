import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

class ThemeFonts {
  static TextStyle titleFont = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: ScreenUtil().setSp(20),
      fontFamily: 'myFont');

  static TextStyle bodyFont = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: ScreenUtil().setSp(16),
      fontFamily: 'myFont');

  static TextStyle smallFont = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: ScreenUtil().setSp(12),
      color: ThemeColors.colorBlack,
      fontFamily: 'myFont');
  static BoxDecoration lineBoxDecoration = BoxDecoration(
      image: DecorationImage(
    image: AssetImage("assets/images/main_bg_with_blank.png"),
    fit: BoxFit.none,
    repeat: ImageRepeat.repeat,
  ));
}
