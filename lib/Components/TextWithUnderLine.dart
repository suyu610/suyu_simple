import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextWithUnderLine extends StatelessWidget {
  const TextWithUnderLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Text(
            "黄鹏宇今天表现怎么样",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(18),
              // decorationStyle: TextDecorationStyle.double,
              decorationStyle: TextDecorationStyle.wavy,
              decorationColor: ThemeColors.colorTheme,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
              fontFamily: 'myFont',
            ),
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
