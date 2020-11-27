import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suyu_simple/tools/share_preferences_utils.dart';

class Global {
  static String userID;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // 如果是第一次启动app，则

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
