import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
import 'package:suyu_simple/ui/Components/Mark/MarkMainBox.dart';
import 'package:suyu_simple/ui/Components/MyButton.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';
import 'package:suyu_simple/ui/components/Menu/MenuWidget.dart';
import 'package:suyu_simple/ui/components/Menu/SliderMenuContainer.dart';
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
    await SharePreferencesUtils.token(
      SharePreferencesUtilsWorkType.remove,
    );
    EasyLoading.showSuccess("退出成功");

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  void handleSaveBtnClick() {
    EasyLoading.show();
    Future.delayed(Duration(seconds: 1), () {
      // EasyLoading.dismiss();
      EasyLoading.show(status: "已保存", indicator: Icon(Icons.swap_vert));
    });
    Future.delayed(Duration(milliseconds: 1500), () {
      EasyLoading.dismiss();
    });
    // Toast.show("已保存", context,
    //     gravity: Toast.TOP,
    //     backgroundColor: ThemeColors.colorTheme,
    //     textColor: ThemeColors.colorBlack,
    //     backgroundRadius: 8,
    //     border: Border.all(
    //       width: 2,
    //     ));
  }

  double initial = 0.0;
  double distance = 0.0;
  GlobalKey<SliderMenuState> _key = new GlobalKey<SliderMenuState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _key.currentState.closeDrawer();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onHorizontalDragStart: (DragStartDetails details) {
        initial = details.globalPosition.dx;
        print("开始位置是" + initial.toString());
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        distance = details.globalPosition.dx - initial;
        // print("结束位置是" + distance.toString());
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        initial = 0.0;
        print("移动的距离是" + distance.toString());
        if (distance > 30) {
          _key.currentState.openDrawer();
        }
        if (distance < -30) {
          _key.currentState.closeDrawer();
        }
      },
      child: Container(
        child: SliderMenu(
          appBarPadding: EdgeInsets.only(right: 15.w, left: 10.w, top: 30.h),
          key: _key,
          appBarColor: Colors.transparent,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: handleSaveBtnClick,
                child: Icon(Ionicons.settings_outline),
              ),
            ],
          ),
          title: Text("10月30日周五",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: ScreenUtil().setSp(18),
                  fontFamily:
                      Provider.of<FontFamilyProvider>(context).fontFamily)),
          sliderMenu: MenuWidget(),
          sliderMain: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: Container(
              // color: Colors.white,
              decoration: ThemeFonts.lineBoxDecoration,
              child: Stack(
                alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  Positioned(
                    left: ScreenUtil().setWidth(14),
                    right: ScreenUtil().setWidth(14),
                    top: ScreenUtil().setHeight(20),
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   // color: Colors.red,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       GestureDetector(
                        //         onTap: handleSaveBtnClick,
                        //         child: Icon(Ionicons.cloud_done_outline),
                        //       )
                        //     ],
                        //   ),
                        // ),

                        //中间的大盒子
                        MarkMainBox(),
                        Padding(padding: EdgeInsets.all(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MyButton(
                              "完美",
                              width: 120,
                              isYellow: true,
                              tapAction: handleResetBtnClick,
                            ),
                            MyButton("提交",
                                width: 170,
                                isYellow: false,
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
        ),
      ),
    );
  }
}
