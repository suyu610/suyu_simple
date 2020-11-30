import 'package:cool_alert/cool_alert.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/net/api.dart';
import 'package:suyu_simple/provider/user_provider.dart';
import 'package:suyu_simple/route/RouterHelper.dart';
import 'package:suyu_simple/tools/share_preferences_utils.dart';
import 'package:suyu_simple/tools/str_utils.dart';
import 'package:suyu_simple/ui/pages/Profile.dart';

import 'base_model.dart';

class ProfileViewModel extends BaseModel {
  BuildContext context;

  ProfileViewModel(Api api, this.context) : super(api: api);
  void handleHeartBtnClick() {
    CoolAlert.show(
      context: context,
      lottieAsset: "assets/images/cry.json",
      type: CoolAlertType.confirm,
      backgroundColor: ThemeColors.colorTheme,
      title: "你要和他断绝关系吗?",
      confirmBtnText: "按错了",
      cancelBtnText: "确定",
      confirmBtnColor: Colors.black,
      animType: CoolAlertAnimType.slideInUp,
      confirmBtnTextStyle: TextStyle(
          color: ThemeColors.colorWhite, fontWeight: FontWeight.normal),
      cancelBtnTextStyle: TextStyle(color: Colors.black),
      onCancelBtnTap: () => {
        Navigator.pop(context),
        RouterHelper.router.navigateTo(context, "/break_game",
            transition: TransitionType.native)
      },
      onConfirmBtnTap: () => Navigator.pop(context),
    );
  }

  String currentText = "";

  bool hasFriend = false;
  String friendName = "";

  void dispose() {
    super.dispose();
    print("摧毁Profile");
  }

  void initState() {
    hasFriend =
        Provider.of<UserProvider>(context, listen: false).getUser().friend !=
            null;
    friendName = "";
    if (hasFriend) {
      friendName = Provider.of<UserProvider>(context, listen: false)
          .getUser()
          .friend
          .friendNickname;
    }

    hasFriend = false;
  }

  void handleNameTap() {
    showModalBottomSheet(
        context: context,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (BuildContext context) {
          return bottomSheet(context, this);
        });
  }

  void handleSearchBtnClick() {
    print(currentText);
    if (StrUtil.isNumber(currentText) && currentText.length == 5) {
      EasyLoading.show();
    } else {
      EasyLoading.showError("\nid是数字，并且是5位数");
    }
  }

  Future<void> handleExitBtnClick() async {
    await SharePreferencesUtils.token(
      SharePreferencesUtilsWorkType.remove,
    );
    EasyLoading.showSuccess("退出成功");
    RouterHelper.router.navigateTo(context, "/login",
        transition: TransitionType.fadeIn, clearStack: true);
  }
}
