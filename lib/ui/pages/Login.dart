// import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crypto/crypto.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
import 'package:suyu_simple/common/MyTheme.dart';
import 'package:suyu_simple/provider/ThemeProvider.dart';
import 'package:suyu_simple/ui/components/DraggableCard.dart';
import 'package:suyu_simple/ui/components/UnShapedInput.dart';
import 'package:suyu_simple/utils/loading_utils.dart';
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
  Image logoImage;
  bool isRegMode;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(logoImage.image, context);
  }

  Future<void> handleDoneBtn() async {
    EasyLoading.show();
    if (isRegMode) {
      if (usernameController.text.isEmpty ||
          passwordController.text.isEmpty ||
          nicknameController.text.isEmpty) {
        EasyLoading.showInfo("信息不能为空");
      } else {
        var params = new Map<String, dynamic>();
        params["nickname"] = nicknameController.text;
        params["username"] = usernameController.text;
        params["password"] = passwordController.text;
        Dio dio = new Dio();
        try {
          await dio
              .post("http://192.168.43.178:8088/user/reg",
                  queryParameters: params)
              .then((value) {
            print("---------");
            if (value.data["status"] != 200) {
              LoadingUtils.dismiss();
              EasyLoading.showError(value.data["msg"]);
            } else {
              LoadingUtils.dismiss();

              EasyLoading.showSuccess("注册成功");
              handleClickChangeRegModeBtnClick();
            }
          });
        } catch (e) {
          LoadingUtils.dismiss();
          EasyLoading.showError("服务器有问题!!");
        }
      }
    } else {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        EasyLoading.showInfo("信息不能为空");
      } else {
        var params = new Map<String, dynamic>();
        params["username"] = usernameController.text;
        params["password"] =
            md5.convert(utf8.encode(passwordController.text)).toString();
        Dio dio = new Dio();
        try {
          await dio
              .post("http://192.168.43.178:8088/user/loginByPwd",
                  queryParameters: params)
              .then((value) {
            print("---------");
            if (value.data["status"] != 200) {
              LoadingUtils.dismiss();
              EasyLoading.showError(value.data["msg"]);
            } else {
              LoadingUtils.dismiss();
              EasyLoading.showSuccess("登陆成功");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            }
            print("---------");
          });
        } catch (e) {
          LoadingUtils.dismiss();
          EasyLoading.showError("请检查网络!!");
        }
      }
    }
  }

  TextEditingController nicknameController;
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    isRegMode = false;
    logoImage = Image.asset("assets/images/logo_trans.png");
    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    nicknameController = new TextEditingController();

    rotationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    rotationController.repeat(reverse: false);

    curved_1 = new CurvedAnimation(
        parent: rotationController, curve: Curves.easeInCubic); //模仿小球自由落体运动轨迹
    curved_2 = new CurvedAnimation(
        parent: rotationController, curve: Curves.linear); //模仿小球自由落体运动轨迹

    _usrController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _pswController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    Future.delayed(Duration(milliseconds: 200), () {
      _usrController.forward(from: 0.0);
    });
    Future.delayed(Duration(milliseconds: 500), () {
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

  void handleClickChangeRegModeBtnClick() {
    nicknameController.text = "";
    passwordController.text = "";
    usernameController.text = "";
    isRegMode = !isRegMode;
    setState(() {});
  }

  void stopAndStartLogo() {
    isStart ? rotationController.repeat() : rotationController.stop();
    isStart = !isStart;
    setState(() {});
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
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      icon:
                          Provider.of<FontFamilyProvider>(context, listen: true)
                                  .isUseCustomFontFamily
                              ? Icon(Ionicons.color_palette_sharp)
                              : Icon(Ionicons.color_palette_outline),
                      color: Theme.of(context).textSelectionColor,
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
              AnimatedOpacity(
                //如果等于0，则说明没有键盘
                opacity:
                    MediaQuery.of(context).viewInsets.bottom == 0 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 150),

                child: DraggableCard(
                  child: Container(
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
                            child: Hero(
                              tag: "logoImg",
                              child: SizedBox(height: 80.0, child: logoImage),
                            ),
                            onTap: stopAndStartLogo,
                            onLongPress: stopAndStartLogo,
                          )),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    isRegMode ? "注册" : "登陆",
                    style: TextStyle(
                      color: Theme.of(context).textSelectionColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      decorationStyle: TextDecorationStyle.solid,
                      // decorationStyle: TextDecorationStyle.wavy,
                      decorationColor: ThemeColors.colorTheme,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      fontFamily:
                          Provider.of<FontFamilyProvider>(context).fontFamily,
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: _usrOffsetAnimation,
                        child: UnShapedInput(
                          icon: isRegMode
                              ? Ionicons.flash_outline
                              : Ionicons.person_outline,
                          text: isRegMode ? "昵称" : "账号",
                          controller: isRegMode
                              ? nicknameController
                              : usernameController,
                        ),
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          child: Container(
                            child: !isRegMode
                                ? null
                                : SizedBox(
                                    height: 20.h,
                                  ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: isRegMode ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        // child: SlideTransition(
                        // position: _pswOffsetAnimation,
                        child: UnShapedInput(
                          icon: Ionicons.person_outline,
                          text: "账号",
                          controller: usernameController,
                        ),
                        // ),
                      ),
                      AnimatedSize(
                        vsync: this,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          child: Container(
                            child: !isRegMode
                                ? null
                                : SizedBox(
                                    height: 20.h,
                                  ),
                          ),
                        ),
                      ),
                      SlideTransition(
                        position: _pswOffsetAnimation,
                        child: UnShapedInput(
                          icon: Ionicons.lock_closed_outline,
                          text: "密码",
                          controller: passwordController,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ScaleTransition(
                        scale:
                            Tween(begin: 0.0, end: 1.0).animate(_usrController),
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
                                  isRegMode
                                      ? Ionicons.close_outline
                                      : Ionicons.add_outline,
                                  color: Colors.white,
                                ),
                                onPressed: handleClickChangeRegModeBtnClick,
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
                                  isRegMode
                                      ? Icons.done_sharp
                                      : Icons.arrow_right_alt_sharp,
                                  color: Colors.white,
                                ),
                                onPressed: handleDoneBtn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    vsync: this,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      child: Container(
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).viewInsets.bottom * 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 10.h,
                width: 375.w,
                child: Center(
                  child: TextButton(
                      onPressed: () => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          })),
                      child: Text(
                        "单人模式",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
