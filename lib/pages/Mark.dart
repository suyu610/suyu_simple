import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/Components/MarkMainBox.dart';
import 'package:suyu_simple/Components/MyButton.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';
import 'package:toast/toast.dart';

import 'Login.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  Future<void> handleSubmitBtnClick() async {
    print("提交按钮被按");
    var token = "123456";
    bool saveScuess = await SharePreferencesUtils.token(
        SharePreferencesUtilsWorkType.save,
        value: token);
    saveScuess ? print('token 保存成功') : print('token 保存失败');
  }

  Future<void> handleResetBtnClick() async {
    print("重置按钮被按");
    await SharePreferencesUtils.token(
      SharePreferencesUtilsWorkType.remove,
    );
    Toast.show('重置成功', context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Container(
          decoration: ThemeFonts.lineBoxDecoration,
          child: Stack(
            alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
            children: <Widget>[
              Positioned(
                left: ScreenUtil().setWidth(14),
                right: ScreenUtil().setWidth(14),
                top: ScreenUtil().setHeight(50),
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
                        IconButton(
                          tooltip: "自动保存",
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(0.00),
                          onPressed: () => Toast.show("已保存", context,
                              gravity: Toast.TOP,
                              backgroundColor: ThemeColors.colorTheme,
                              textColor: ThemeColors.colorBlack,
                              backgroundRadius: 8,
                              border: Border.all(
                                width: 2,
                              )),
                          icon: Icon(Icons.cloud_upload),
                          // color: ThemeColors.colorTheme,
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("已经连续优秀第 ", style: ThemeFonts.smallFont),
                        Text("4",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationThickness: 3,
                                decorationColor: ThemeColors.colorTheme,
                                // decoration: TextDecoration.underline,
                                fontSize: ScreenUtil().setSp(12),
                                color: ThemeColors.colorBlack,
                                fontFamily: 'myFont')),
                        Text(" 天", style: ThemeFonts.smallFont),
                      ],
                    ),

                    Padding(padding: EdgeInsets.all(10)),
                    //中间的大盒子
                    MarkMainBox(),
                    Padding(padding: EdgeInsets.all(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MyButton(
                          width: 117.w,
                          height: 24.h,
                          title: "完美",
                          isYellow: true,
                          fontSize: 15.sp,
                          tapAction: handleResetBtnClick,
                        ),
                        MyButton(
                            width: 166.w,
                            height: 24.h,
                            title: "提交",
                            isYellow: false,
                            fontSize: 15,
                            tapAction: handleSubmitBtnClick),
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
      ),
    );
  }
}
