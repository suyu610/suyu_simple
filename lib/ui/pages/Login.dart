// import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/animation.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

import 'package:suyu_simple/provider/FontFamilyProvider.dart';

import 'package:suyu_simple/common/MyTheme.dart';
// import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/provider/ThemeProvider.dart';
// import 'package:suyu_simple/tools/DioUtils.dart';

// import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  String data = "";
  AnimationController rotationController;
  AnimationController _usrController;
  AnimationController _pswController;
  Animation<Offset> _usrOffsetAnimation;
  Animation<Offset> _pswOffsetAnimation;

  CurvedAnimation curved_1; //曲线动画，动画插值，
  CurvedAnimation curved_2;

  @override
  void initState() {
    super.initState();
    // FormData formData = new FormData.from({
    //   "uuid": "9dad1c81889ff0ea8c8c5ade6a5e36e3",
    //   "sign": "",
    //   "sso_id": "",
    //   "own_version": "100",
    //   "channel": "ios",
    //   "dev_os_version": "iOS12.3.1",
    //   "timestamp": "1564974676",
    //   "screen_size": "[375,667]",
    //   "is_jailbreak": 0,
    //   "os": "ios",
    //   "device_name": "iPhone6S",
    //   "os_version": "",
    //   "country_code": "CN",
    //   "ios_version": "1.0.0",
    // });
    //发送网络请求
    // DioUtils.postHttp(
    //   "huhuapi/firstnew/indexnew.html",
    //   parameters: formData,
    //   onSuccess: (data) {
    //     setState(() {
    //       this.data = data;
    //     });
    //     Toast.show('来了', context, gravity: Toast.CENTER);
    //   },
    //   onError: (error) {
    //     Toast.show(error, context);
    //   },
    // );
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 9000),
      vsync: this,
    );
    rotationController.repeat(reverse: false);

    curved_1 = new CurvedAnimation(
        parent: rotationController, curve: Curves.linear); //模仿小球自由落体运动轨迹
    curved_2 = new CurvedAnimation(
        parent: rotationController, curve: Curves.linear); //模仿小球自由落体运动轨迹

    _usrController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _pswController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 200), () {
      _usrController.forward(from: 0.0);
    });
    Future.delayed(Duration(milliseconds: 300), () {
      _pswController.forward(from: 0.0);
    });

    _usrOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _usrController,
      curve: Curves.linearToEaseOut,
    ));

    _pswOffsetAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _pswController,
      curve: Curves.linearToEaseOut,
    ));
  }

  bool isDarkMode = false;
  void handleChangeFont() {
    Provider.of<FontFamilyProvider>(context, listen: false).changeFont();
  }

  bool isStart = false;

  void changeTheme() {
    Provider.of<ThemeProvider>(context, listen: false)
        .changeTheme(isDarkMode ? lightTheme : darkTheme);
    isDarkMode = !isDarkMode;

    setState(() {});
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            image: DecorationImage(
              image: AssetImage("assets/images/main_bg_with_blank.png"),
              fit: BoxFit.none,
              repeat: ImageRepeat.repeat,
            )),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //  Provider.of<FontFamilyProvider>(context, listen: false).fontFamily
                  IconButton(
                      icon:
                          Provider.of<FontFamilyProvider>(context, listen: true)
                                  .isUseCustomFontFamily
                              ? Icon(Ionicons.color_palette_sharp)
                              : Icon(Ionicons.color_palette_outline),
                      color:
                          Provider.of<FontFamilyProvider>(context, listen: true)
                                  .isUseCustomFontFamily
                              ? ThemeColors.colorTheme
                              : Colors.black,
                      onPressed: handleChangeFont),

                  IconButton(
                      icon: Icon(
                          isDarkMode ? Ionicons.moon_sharp : Ionicons.sunny),
                      color: Theme.of(context).textSelectionColor,
                      onPressed: changeTheme),
                  SizedBox(
                    width: 10.w,
                  )
                ],
              ),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(0.h),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff000000),
                                spreadRadius: 2.0,
                                offset: Offset(5.0, 6.0),
                              )
                            ],
                            color: ThemeColors.colorTheme,
                            // color: Colors.orange[300],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(50, 23),
                              topRight: Radius.elliptical(20, 79),
                              bottomRight: Radius.elliptical(50, 19),
                              bottomLeft: Radius.elliptical(30, 32),
                            )),
                        child: RotationTransition(
                          turns: curved_2,
                          child: SizedBox(
                              height: 70.0.h,
                              width: 70.0.h,
                              child: GestureDetector(
                                child:
                                    Image.asset("assets/images/logo_trans.png"),
                                onTap: speedUp,
                                onLongPress: speedUp,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SlideTransition(
                    position: _usrOffsetAnimation,
                    child: Container(
                      width: 320.w,
                      padding: EdgeInsets.only(left: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(50, 23),
                          topRight: Radius.elliptical(90, 19),
                          bottomRight: Radius.elliptical(50, 99),
                          bottomLeft: Radius.elliptical(50, 92),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeColors.colorTheme,
                            // color: Colors.orange[300],
                            spreadRadius: 2.0,
                            offset: Offset(3.0, 4.0),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.person_outline,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            height: 30.h,
                            width: 280.w,
                            child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                maxLines: 1,
                                cursorColor: Colors.white,
                                cursorWidth: 2.w,
                                cursorRadius: Radius.circular(2.w),
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "kaitifont",
                                    ),
                                    isDense: true,
                                    hintText: "username",
                                    border: InputBorder.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SlideTransition(
                    position: _pswOffsetAnimation,
                    child: Container(
                      width: 320.w,
                      padding: EdgeInsets.only(left: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20, 13),
                          topRight: Radius.elliptical(45, 29),
                          bottomRight: Radius.elliptical(30, 19),
                          bottomLeft: Radius.elliptical(30, 32),
                        ),
                        boxShadow: [
                          BoxShadow(
                            // color: Colors.orange[300],
                            color: ThemeColors.colorTheme,
                            spreadRadius: 1.0,
                            offset: Offset(3.0, 4.0),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.lock_closed_outline,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            height: 30.h,
                            width: 280.w,
                            child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                cursorColor: Colors.white,
                                cursorWidth: 2.w,
                                cursorRadius: Radius.circular(2.w),
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "kaitifont",
                                    ),
                                    isDense: true,
                                    hintText: "password",
                                    border: InputBorder.none)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0).animate(_usrController),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  // color: Colors.orange[300],
                                  color: ThemeColors.colorTheme,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 4.0),
                                )
                              ],
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(20, 53),
                                topRight: Radius.elliptical(39, 11),
                                bottomRight: Radius.elliptical(50, 49),
                                bottomLeft: Radius.elliptical(23, 32),
                              )),
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Ionicons.add_outline,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            })),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Container(
                          padding: EdgeInsets.all(2.h),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ThemeColors.colorTheme,
                                  spreadRadius: 2.0,
                                  offset: Offset(3.0, 4.0),
                                )
                              ],
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.elliptical(20, 33),
                                topRight: Radius.elliptical(29, 31),
                                bottomRight: Radius.elliptical(50, 49),
                                bottomLeft: Radius.elliptical(30, 32),
                              )),
                          child: IconButton(
                            iconSize: 30,
                            icon: Icon(
                              Icons.arrow_right_alt_sharp,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            })),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom + 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void speedUp() {
    isStart ? rotationController.repeat() : rotationController.stop();
    isStart = !isStart;
    setState(() {});
  }
}
