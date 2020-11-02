import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

// ignore: non_constant_identifier_names
TransitionBuilder EasyLoadingInit() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 25.0
    ..radius = 10.0
    ..backgroundColor = ThemeColors.colorTheme
    ..indicatorColor = ThemeColors.colorWhite
    ..textColor = ThemeColors.colorBlack
    ..textStyle = TextStyle(fontWeight: FontWeight.w500)
    ..fontSize = 13
    ..contentPadding = EdgeInsets.all(20)
    ..textPadding = EdgeInsets.only(bottom: 20)
    ..progressColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.4)
    ..userInteractions = true;

  return (_, Widget child) {
    return FlutterEasyLoading(child: child);
  };
}