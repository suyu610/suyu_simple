import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          Positioned(
            left: ScreenUtil().setWidth(14),
            right: ScreenUtil().setWidth(14),
            top: ScreenUtil().setHeight(60),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("素语"),
                    Row(children: <Widget>[
                      Icon(Icons.calendar_today),
                      Text(
                        "10月30日 周五",
                        style: ThemeFonts.titleFont,
                      ),
                    ]),
                    Text(
                      "已保存",
                      style: ThemeFonts.smallFont,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("已经连续优秀第4天", style: ThemeFonts.smallFont),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
