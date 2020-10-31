import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

Widget myButton(
    {double height = 28,
    double width,
    String title,
    bool isYellow = false,
    Function() tapAction}) {
  return SizedBox(
      width: ScreenUtil().setWidth(width),
      height: ScreenUtil().setHeight(height),
      child: FlatButton(
        splashColor: isYellow ? ThemeColors.colorTheme : ThemeColors.colorWhite,
        color: isYellow ? ThemeColors.colorTheme : ThemeColors.colorWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
                color: ThemeColors.colorBlack,
                style: BorderStyle.solid,
                width: 3)),
        onPressed: tapAction,
        child: Text(
          title,
          style: TextStyle(color: ThemeColors.colorBlack, fontFamily: 'myFont'),
        ),
      ));
}
