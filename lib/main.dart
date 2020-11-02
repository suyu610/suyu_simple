import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suyu_simple/pages/Home.dart';
import 'package:suyu_simple/pages/Login.dart';
import 'package:suyu_simple/provider/DailyMarkProvider.dart';
import 'package:suyu_simple/provider/TabbarProvider.dart';
import 'package:suyu_simple/provider/TableProvider.dart';
import 'package:suyu_simple/tools/InitUtils.dart';

import 'common/Global.dart';
import 'common/ThemeColor.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  Global.init().then((e) => runApp(MyApp()));

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ListenableProvider<TableProvide>(create: (_) => TableProvide()),
          ListenableProvider<DailyMarkProvider>(
              create: (_) => DailyMarkProvider()),
          ListenableProvider<TabbarProvider>(create: (_) => TabbarProvider()),
        ],
        child: MaterialApp(
          // ignore: missing_return
          builder: EasyLoadingInit(),
          title: 'Material Components',
          theme: ThemeData(
            primaryColor: ThemeColors.colorTheme,
          ),
          home: Main(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  var loginState;
  Future checkLogin() async {
    Future<dynamic> token = Future(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString("token");
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
