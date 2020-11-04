import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

// ignore: must_be_immutable
class MyButton extends StatefulWidget {
  MyButton(this.title,
      {this.height = 28,
      this.width = 117,
      this.isYellow,
      this.fontSize = 15,
      this.tapAction,
      Key key})
      : super(key: key);

  double height = 28;
  double width;
  String title;
  bool isYellow = false;
  double fontSize = 15;
  Function tapAction;

  @override
  _MyButtonState createState() => _MyButtonState();
}

// ignore: camel_case_types
class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ScreenUtil().setWidth(widget.width),
        height: ScreenUtil().setHeight(widget.height),
        child: FlatButton(
          splashColor:
              widget.isYellow ? ThemeColors.colorTheme : ThemeColors.colorWhite,
          color:
              widget.isYellow ? ThemeColors.colorTheme : ThemeColors.colorWhite,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(
                  color: ThemeColors.colorBlack,
                  style: BorderStyle.solid,
                  width: 3)),
          onPressed: widget.tapAction,
          child: Text(
            widget.title,
            style: TextStyle(
                color: ThemeColors.colorBlack,
                fontFamily: 'myFont',
                fontSize: ScreenUtil().setSp(widget.fontSize),
                fontWeight: FontWeight.w400),
          ),
        ));
  }
}
