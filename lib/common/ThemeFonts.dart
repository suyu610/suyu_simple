import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

class ThemeFonts {
  static TextStyle titleFont =
      TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(20));
  static TextStyle bodyFont = TextStyle(
      fontWeight: FontWeight.normal, fontSize: ScreenUtil().setSp(16));
  static TextStyle smallFont = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: ScreenUtil().setSp(12),
      color: ThemeColors.colorDDDDDD);
}
