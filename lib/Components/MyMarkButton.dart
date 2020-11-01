import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

// ignore: must_be_immutable
class MyMarkButton extends StatefulWidget {
  MyMarkButton(
      {this.height = 30,
      this.width,
      this.isYellow = false,
      this.fontSize = 14,
      this.tapAction,
      Key key,
      this.isAdd})
      : super(key: key);

  double height;
  double width;
  bool isYellow;
  bool isAdd;
  double fontSize;
  Function tapAction;
  Timer timer;

  @override
  _MyMarkButtonState createState() =>
      _MyMarkButtonState(height, width, isYellow, isAdd, fontSize, tapAction);
}

class _MyMarkButtonState extends State<MyMarkButton> {
  _MyMarkButtonState(
    this.height,
    this.width,
    this.isYellow,
    this.isAdd,
    this.fontSize,
    this.tapAction,
  );

  double height;
  double width;
  bool isYellow;
  bool isAdd;
  double fontSize;
  Function tapAction;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: GestureDetector(
          onLongPress: () {
            timer = Timer.periodic(Duration(milliseconds: 100), (e) {
              tapAction();
            });
            print("手指按下");
          },
          onLongPressUp: () {
            print(timer);
            if (timer != null) {
              print("手指松开");
              timer.cancel();
            }
          },
          // 这里防止长按没有抬起手指，而move到了别处，会继续 --
          onTapCancel: () {
            if (timer != null) {
              timer.cancel();
            }
          },
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
            padding: EdgeInsets.all(0),
            child: Icon(
              isAdd ? Icons.add : Icons.navigate_before,
              size: height / 1.5,
              color: ThemeColors.colorBlack,
            ),
          ),
        ));
  }
}
