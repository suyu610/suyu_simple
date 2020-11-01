import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

Widget myButton(
    {double height = 28,
    double width,
    String title,
    bool isYellow = false,
    double fontSize = 15,
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
          style: TextStyle(
              color: ThemeColors.colorBlack,
              fontFamily: 'myFont',
              fontSize: fontSize,
              fontWeight: FontWeight.w400),
        ),
      ));
}

Widget myMarkButton(
    {double height = 28,
    double width,
    bool isAdd = true,
    bool isYellow = true,
    Function() tapAction}) {
  return SizedBox(
      width: ScreenUtil().setWidth(width),
      height: ScreenUtil().setHeight(height),
      child: FlatButton(
        splashColor: isYellow
            ? ThemeColors.colorTheme
            : ThemeColors.colorWhite, // : ThemeColors.colorWhite,
        color: isYellow
            ? ThemeColors.colorTheme
            : ThemeColors.colorWhite, //: ThemeColors.colorWhite,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
                color: ThemeColors.colorBlack,
                style: BorderStyle.solid,
                width: 3)),
        onPressed: tapAction,
        child: Icon(
          isAdd ? Icons.add : Icons.navigate_before,
          size: height,
          color: ThemeColors.colorBlack,
        ),
      ));
}
