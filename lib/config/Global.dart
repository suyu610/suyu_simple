import 'dart:io';
import 'dart:ui';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/route/RouterConfig.dart';
import 'package:suyu_simple/route/RouterHelper.dart';
import 'package:suyu_simple/tools/share_preferences_utils.dart';

class Global {
  static String userID;

  //初始化全局信息，会在APP启动时执行

  static Future init() async {
    // 初始化配置toast
    initToast();
    // 初始化路由
    final router = FluroRouter();
    RouterConfig.configureRoutes(router);
    RouterHelper.router = router;
    // 指定手机方向
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // 如果是第一次启动app
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.get("firstLauch") == null) {
      firstLauchApp();
    }

    // 检查token

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

// 当第一次打开app时，应该进行的流程
void firstLauchApp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // 创建数据库
  // 创建 user 文件
  // 创建签名文件
  SharePreferencesUtils.sign(
    SharePreferencesUtilsWorkType.save,
    value: "",
  );
  prefs.setString("firstLauch", "");
}

void initToast() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.hourGlass
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 25.0
    ..radius = 10.0
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..backgroundColor = ThemeColors.colorTheme
    ..indicatorColor = Colors.black
    ..textColor = ThemeColors.colorBlack
    ..textStyle = TextStyle(fontWeight: FontWeight.w500)
    ..fontSize = 13
    ..contentPadding = EdgeInsets.all(20)
    ..textPadding = EdgeInsets.only(bottom: 20)
    ..progressColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.4)
    ..userInteractions = true;
}
