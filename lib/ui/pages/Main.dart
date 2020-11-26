import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';
import 'package:suyu_simple/ui/pages/Home.dart';
import 'package:suyu_simple/ui/pages/Login.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  var loginState;
  Future checkLogin() async {
    Future<dynamic> token = Future(() async {
      return SharePreferencesUtils.suyuUserVo(
          SharePreferencesUtilsWorkType.get);
    });

    token.then((value) {
      if (value == null) {
        setState(() {
          loginState = 0;
        });
      } else {
        setState(() {
          loginState = 1;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // 一个异步操作
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 667), allowFontScaling: true);
    if (loginState == 0) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}
