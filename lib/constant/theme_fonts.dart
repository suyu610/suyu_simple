import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/constant/theme_color.dart';

class ThemeFonts {
  static TextStyle titleFont = TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: ScreenUtil().setSp(20),
      fontFamily: 'kaitiFont');

  static TextStyle bodyFont = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: ScreenUtil().setSp(16),
      fontFamily: 'kaitiFont');

  static TextStyle smallFont = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: ScreenUtil().setSp(12),
      color: ThemeColors.colorBlack,
      fontFamily: 'kaitiFont');

  static BoxDecoration lineBoxDecoration = BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        image: AssetImage("assets/images/main_bg_with_blank.png"),
        fit: BoxFit.none,
        repeat: ImageRepeat.repeat,
      ));
}
