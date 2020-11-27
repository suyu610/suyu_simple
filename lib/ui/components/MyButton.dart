import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/constant/ThemeColor.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';

// ignore: must_be_immutable
class MyButton extends StatefulWidget {
  MyButton(this.title,
      {this.height = 32,
      this.width = 117,
      this.isYellow = false,
      this.fontSize = 15,
      this.tapAction,
      Key key})
      : super(key: key);

  double height = 32;
  double width;
  String title;
  bool isYellow;
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
        height: widget.height,
        child: FlatButton(
          splashColor:
              widget.isYellow ? ThemeColors.colorTheme : Colors.transparent,
          color: widget.isYellow ? ThemeColors.colorTheme : Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(
                  color: Theme.of(context).textSelectionColor,
                  style: BorderStyle.solid,
                  width: 3)),
          onPressed: widget.tapAction,
          child: Text(
            widget.title,
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontFamily: Provider.of<FontFamilyProvider>(context).fontFamily,
                fontSize: ScreenUtil().setSp(widget.fontSize),
                fontWeight: FontWeight.w400),
          ),
        ));
  }
}
