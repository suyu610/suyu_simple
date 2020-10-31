import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';

import 'MarkDetailLi.dart';

class MarkMainBox extends StatefulWidget {
  MarkMainBox({Key key}) : super(key: key);

  @override
  _MarkMainBoxState createState() => _MarkMainBoxState();
}

class _MarkMainBoxState extends State<MarkMainBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Container(
                    color: ThemeColors.colorTheme,
                    height: ScreenUtil().setHeight(10),
                    width: ScreenUtil().setWidth(230),
                  ),
                ),
                Text(
                  "黄鹏宇今天表现怎么样",
                  style: ThemeFonts.titleFont,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            MarkDetailLi(),
            MarkDetailLi(),
            Text("还行"),
          ],
        ),
      ),
      height: ScreenUtil().setHeight(393),
      width: ScreenUtil().setWidth(343),
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.colorBlack,
          width: 3.0, //边框粗细
        ), //容器内的方框弧度
        borderRadius: BorderRadius.all(const Radius.circular(10.0)),
      ),
    );
  }
}
