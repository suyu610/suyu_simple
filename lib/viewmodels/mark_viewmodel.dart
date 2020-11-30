import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/model/daily_recorder.dart';
import 'package:suyu_simple/net/api.dart';
import 'package:suyu_simple/provider/daily_mark_provider.dart';
import 'package:suyu_simple/provider/theme_provider.dart';
import 'package:suyu_simple/provider/user_provider.dart';
import 'package:suyu_simple/sampleData/sample_date.dart';

import 'base_model.dart';

class MarkViewModel extends BaseModel {
  BuildContext context;
  DailyRecorder dailyRecorder = SampleDate.todayRecorder;

  MarkViewModel(Api api, this.context) : super(api: api);

  void toggle(DragEndDetails details) {
    Provider.of<ThemeProvider>(context, listen: false)
        .innerDrawerKey
        .currentState
        .toggle(direction: InnerDrawerDirection.start);
  }

  Future<void> handleSubmitBtnClick() async {
    CoolAlert.show(
      context: context,
      lottieAsset: "assets/lotties/question-mark.json",
      type: CoolAlertType.confirm,
      backgroundColor: ThemeColors.colorTheme,
      title: "确认提交吗?",
      confirmBtnText: "确定",
      cancelBtnText: "取消",
      confirmBtnColor: Colors.black,
      animType: CoolAlertAnimType.slideInUp,
      confirmBtnTextStyle: TextStyle(
          color: ThemeColors.colorWhite, fontWeight: FontWeight.normal),
      cancelBtnTextStyle: TextStyle(color: Colors.black),
      onCancelBtnTap: () => Navigator.pop(context),
      onConfirmBtnTap: () => {},
    );
  }

  String title() {
    return "${Provider.of<UserProvider>(context).getUser().nickname}今天表现怎么样";
  }

  void dispose() {
    print("摧毁");
    super.dispose();
  }

  void handleSaveBtnClick() {
    EasyLoading.show();
    Future.delayed(Duration(seconds: 1), () {
      // EasyLoading.dismiss();
      EasyLoading.show(status: "已保存", indicator: Icon(Icons.swap_vert));
    });
    Future.delayed(Duration(milliseconds: 1500), () {
      EasyLoading.dismiss();
    });
  }

  Future<void> handlePerfectBtnClick() async {
    Provider.of<DailyMarkProvider>(context, listen: false).perfect();
  }

  String nowDate() {
    DateTime today = new DateTime.now();
    String weekday = "一";
    switch (today.weekday) {
      case 2:
        weekday = "二";
        break;
      case 3:
        weekday = "三";
        break;
      case 4:
        weekday = "四";
        break;
      case 5:
        weekday = "五";
        break;
      case 6:
        weekday = "六";
        break;
      case 7:
        weekday = "日";
        break;
    }
    return ("${today.month}月${today.day}日星期$weekday");
  }

  void openMenu() {
    Provider.of<ThemeProvider>(context, listen: false)
        .innerDrawerKey
        .currentState
        .toggle(direction: InnerDrawerDirection.start);
  }
}
