import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/tools/share_preferences_utils.dart';

class Global {
  static String userID;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    initToast();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // 如果是第一次启动app
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isFirstLauch = prefs.get("firstLauch");
    if (isFirstLauch == null) {
      print("是第一次启动");
      SharePreferencesUtils.sign(
        SharePreferencesUtilsWorkType.save,
        value: "",
      );
      //设置为不是第一次启动
      prefs.setString("firstLauch", "");
    }

    // 检查token

    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
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
