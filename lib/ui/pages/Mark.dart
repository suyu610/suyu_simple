import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/provider/ThemeProvider.dart';
import 'package:suyu_simple/ui/Components/Mark/MarkMainBox.dart';
import 'package:suyu_simple/ui/Components/MyButton.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';
import 'package:suyu_simple/ui/components/Menu/MenuWidget.dart';

class MarkPage extends StatefulWidget {
  MarkPage({Key key}) : super(key: key);

  @override
  _MarkPageState createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  Future<void> handleSubmitBtnClick() async {
    print("提交按钮被按");
    var token = "123456";
    await SharePreferencesUtils.token(SharePreferencesUtilsWorkType.save,
        value: token);
  }

  Future<void> handlePerfectBtnClick() async {}

  void _toggle(DragEndDetails details) {
    Provider.of<ThemeProvider>(context, listen: false)
        .innerDrawerKey
        .currentState
        .toggle(
            // direction is optional
            // if not set, the last direction will be used
            //InnerDrawerDirection.start OR InnerDrawerDirection.end
            direction: InnerDrawerDirection.start);
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

  @override
  void dispose() {
    print('移除时：dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: Provider.of<ThemeProvider>(context, listen: false).innerDrawerKey,
      onTapClose: true, // default false
      swipe: true, // default true
      colorTransitionChild: Colors.grey[900], // default Color.black54
      colorTransitionScaffold: Colors.white70, // default Color.black54

      //When setting the vertical offset, be sure to use only top or bottom
      offset: IDOffset.only(bottom: 0, right: 0, left: 0.6),

      // scale: IDOffset.horizontal(1), // set the offset in both directions

      proportionalChildArea: true, // default true
      borderRadius: 0, // default 0
      leftAnimationType: InnerDrawerAnimation.linear, // default static
      backgroundDecoration: BoxDecoration(color: Colors.grey[900]),
      // default  Theme.of(context).backgroundColor
      //when a pointer that is in contact with the screen and moves to the right or left
      // onDragUpdate: (double val, InnerDrawerDirection direction) {
      //   // return values between 1 and 0
      //   print(val);
      //   // check if the swipe is to the right or to the left
      //   print(direction == InnerDrawerDirection.start);
      // },
      innerDrawerCallback: (a) => {},
      // print(a), // return  true (open) or false (close)
      leftChild: GestureDetector(
          onHorizontalDragEnd: _toggle,
          // onTap: _toggle,
          child: MenuWidget()), // required if rightChild is not set

      scaffold: Scaffold(
        key: Provider.of<ThemeProvider>(context).scaffoldKey,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: DirectSelectContainer(
            child: Container(
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Container(
                  // color: Colors.white,
                  decoration: ThemeFonts.lineBoxDecoration,
                  child: Stack(
                    alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                    children: <Widget>[
                      Positioned(
                        // left: ScreenUtil().setWidth(14),
                        right: 14.w,
                        top: 56.h,
                        child: GestureDetector(
                          onTap: handleSaveBtnClick,
                          child: Icon(Ionicons.settings_outline),
                        ),
                      ),
                      Positioned(
                        left: 14.w,
                        // right: ScreenUtil().setWidth(14),
                        top: 56.h,
                        child: GestureDetector(
                          onTap: openMenu,
                          child: Icon(Ionicons.menu),
                        ),
                      ),
                      Positioned(
                        left: ScreenUtil().setWidth(14),
                        right: ScreenUtil().setWidth(14),
                        top: 50.h,
                        child: Column(
                          children: <Widget>[
                            Text("10月30日周五",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: ScreenUtil().setSp(24),
                                )),
                            SizedBox(
                              height: 40.h,
                            ),
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
                                  tapAction: handlePerfectBtnClick,
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
        ),
      ),
    );
  }

  void openMenu() {
    Provider.of<ThemeProvider>(context, listen: false)
        .innerDrawerKey
        .currentState
        .toggle(direction: InnerDrawerDirection.start);
  }
}
