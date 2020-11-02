/// 数字滚动效果
///
/// created by hujintao
/// created at 2020-03-12
//
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

// ignore: must_be_immutable
class RollingText extends StatefulWidget {
  int leftNum;
  int rightNum;

  Color textColor;

  RollingText({
    this.leftNum = 3,
    this.rightNum = 7,
    this.textColor = const Color(0xffED9CBE),
  });

  @override
  _RollingTextState createState() => _RollingTextState();
}

class _RollingTextState extends State<RollingText> {
  List<int> leftData = [];
  List<int> rightData = [];

  ScrollController leftView = ScrollController();

  ScrollController rightView = ScrollController();

  void _leftToEnd() {
    leftView.animateTo(leftView.position.maxScrollExtent,
        duration: Duration(milliseconds: 800), curve: Curves.easeIn);
  }

  void _rightToEnd() {
    rightView.animateTo(rightView.position.maxScrollExtent,
        duration: Duration(milliseconds: 1000), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    super.initState();
    leftData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, this.widget.leftNum];
    rightData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, this.widget.rightNum];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Future.delayed(Duration(milliseconds: 300), () async {
      if (this.widget.leftNum != 0) {
        _leftToEnd();
      }
      _rightToEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //left
          this.widget.leftNum != 0
              ? Container(
                  child: SingleChildScrollView(
                    controller: leftView,
                    child: Column(
                      children: leftData.map((num) {
                        return Container(
                          child: Center(
                            child: Text(
                              // ignore: unnecessary_brace_in_string_interps
                              '${num}',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationColor: ThemeColors.colorTheme,
                                decorationThickness: 3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  // width: ScreenUtil().setWidth(40),
                  height: ScreenUtil().setHeight(30),
                )
              : Container(),
          // right
          Container(
            child: SingleChildScrollView(
              controller: rightView,
              child: Column(
                children: rightData.map((num) {
                  return Container(
                    child: Center(
                      child: Text(
                        // ignore: unnecessary_brace_in_string_interps
                        '${num}',
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(30),
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                          decorationColor: ThemeColors.colorTheme,
                          decorationThickness: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
//            width: ScreenUtil().setWidth(40),
            height: ScreenUtil().setHeight(30),
          ),
        ],
      ),
    );
  }
}
