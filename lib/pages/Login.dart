import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suyu_simple/Components/MyButton.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/tools/DioUtils.dart';
import 'package:toast/toast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String data = "";
  @override
  Future initState() {
    super.initState();
    FormData formData = new FormData.from({
      "uuid": "9dad1c81889ff0ea8c8c5ade6a5e36e3",
      "sign": "",
      "sso_id": "",
      "own_version": "100",
      "channel": "ios",
      "dev_os_version": "iOS12.3.1",
      "timestamp": "1564974676",
      "screen_size": "[375,667]",
      "is_jailbreak": 0,
      "os": "ios",
      "device_name": "iPhone6S",
      "os_version": "",
      "country_code": "CN",
      "ios_version": "1.0.0",
    });
    DioUtils.postHttp(
      "huhuapi/firstnew/indexnew.html",
      parameters: formData,
      onSuccess: (data) {
        setState(() {
          this.data = data;
        });

        Toast.show('来了', context, gravity: Toast.CENTER);
      },
      onError: (error) {
        Toast.show(error, context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (BuildContext context, Widget child) {
          /// 确保 loading 组件能覆盖在其他组件之上.
          EasyLoading.instance
            ..displayDuration = const Duration(milliseconds: 2000)
            ..indicatorType = EasyLoadingIndicatorType.chasingDots
            ..loadingStyle = EasyLoadingStyle.custom
            ..indicatorSize = 25.0
            ..radius = 10.0
            ..backgroundColor = ThemeColors.colorTheme
            ..indicatorColor = ThemeColors.colorBlack
            ..textColor = ThemeColors.colorBlack
            ..fontSize = 13
            ..contentPadding = EdgeInsets.all(20)
            ..textPadding = EdgeInsets.only(bottom: 20)
            ..progressColor = Colors.black
            ..maskColor = Colors.blue.withOpacity(0.5)
            ..userInteractions = true;
          return FlutterEasyLoading(child: child);
        },
        home: Container(
          decoration: ThemeFonts.lineBoxDecoration,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 100),
              ),
              MyButton(
                width: 117,
                height: 30,
                title: "加载中",
                isYellow: false,
                fontSize: 15,
                tapAction: () => EasyLoading.show(status: '正在登录...'),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              MyButton(
                width: 117,
                height: 30,
                title: "取消",
                isYellow: false,
                fontSize: 15,
                tapAction: () => EasyLoading.dismiss(),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              MyButton(
                width: 117,
                height: 30,
                title: "进入首页",
                isYellow: false,
                fontSize: 15,
                tapAction: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return HomePage();
                })),
              ),
            ],
          ),
        ));
  }
}
