import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/Components/CustomLoading.dart';
import 'package:suyu_simple/Components/MarkMainBox.dart';
import 'package:suyu_simple/Components/MyButton.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ConstrainedBox(
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
                      Text("素语", style: TextStyle(fontFamily: 'myFont')),
                      Row(children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: ScreenUtil().setSp(14),
                        ),
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                        ),
                        Text(
                          "10月30日 周五",
                          style: ThemeFonts.titleFont,
                        ),
                      ]),
                      CustomLoadWidget(),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text("已经连续优秀第4天", style: ThemeFonts.smallFont),
                  Padding(padding: EdgeInsets.all(10)),
                  //中间的大盒子
                  MarkMainBox(),
                  Padding(padding: EdgeInsets.all(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyButton(
                        width: 117.w,
                        height: 30.h,
                        title: "重置",
                        isYellow: false,
                        fontSize: 15.sp,
                        tapAction: () => BotToast.showAttachedWidget(
                          attachedBuilder: (_) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          duration: Duration(seconds: 2),
                          target: Offset(1000, 100),
                        ),
                      ),
                      MyButton(
                          width: 166.w,
                          height: 30.h,
                          title: "提交",
                          isYellow: true,
                          fontSize: 15,
                          tapAction: () => print("按了我")),
                    ],
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
