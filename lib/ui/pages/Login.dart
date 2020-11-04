import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/ui/Components/MyButton.dart';
import 'package:suyu_simple/common/MyTheme.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/provider/ThemeProvider.dart';
import 'package:suyu_simple/tools/DioUtils.dart';

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
  // ignore: missing_return
  Future initState() {
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
  }

  bool isDarkMode = false;
  void changeTheme() {
    print("切换主题");
    print(isDarkMode);
    Provider.of<ThemeProvider>(context, listen: false)
        .changeTheme(isDarkMode ? lightTheme : darkTheme);
    isDarkMode = !isDarkMode;
    print(isDarkMode);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),
          SizedBox(
            height: 20.h,
          ),
          MyButton(
            "更换主题风格",
            width: 130,
            height: 30,
            isYellow: false,
            fontSize: 15,
            tapAction: changeTheme,
          ),
          SizedBox(
            height: 20.h,
          ),
          MyButton(
            "进入首页",
            isYellow: false,
            fontSize: 15,
            tapAction: () =>
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return HomePage();
            })),
          ),
        ],
      ),
    );
  }
}
