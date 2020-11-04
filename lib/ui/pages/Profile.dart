import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/ui/Components/MyButton.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/tools/StrUtil.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingController = new TextEditingController();
  String currentText = "";
  void handleSearchBtnClick() {
    print("不能为空");
    if (StrUtil.isNumber(currentText) && currentText.length == 5) {
      EasyLoading.show();
    } else {
      EasyLoading.showError("\nid是数字，并且是5位数");
    }
  }

  var errorController;
  @override
  Widget build(BuildContext context) {
    bool nameIsTap = false;

    void handleNameTap() {
      print("按了一下");
      setState(() {
        nameIsTap = !nameIsTap;
        print(nameIsTap);
      });
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
        EasyLoading.dismiss();
      },
      child: Container(
        decoration: ThemeFonts.lineBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "你的ID是",
              style: ThemeFonts.titleFont,
            ),
            Padding(
              padding: EdgeInsets.all(10.w),
            ),
            GestureDetector(
              onTap: handleNameTap,
              child: Container(
                width: 150.w,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: nameIsTap
                      ? Color.fromRGBO(0, 0, 0, 1)
                      : Color.fromRGBO(254, 212, 91, 1),
                  // boxShadow: [
                  //   new BoxShadow(
                  //       color: Color.fromRGBO(173, 179, 191, 0.3),
                  //       blurRadius: 1.0,
                  //       offset: new Offset(0, 0))
                  // ],
                  border: Border.merge(
                    new Border(
                        left: BorderSide(
                            color: nameIsTap
                                ? ThemeColors.colorTheme
                                : Colors.black,
                            width: 5)),
                    new Border(
                        right: BorderSide(
                            color: nameIsTap
                                ? ThemeColors.colorTheme
                                : Colors.black,
                            width: 5)),
                  ),
                ), // borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.face,
                      color: nameIsTap ? Colors.white : Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 5.w),
                    ),
                    Text(
                      "12345",
                      style: TextStyle(
                          letterSpacing: 5.w,
                          fontWeight: FontWeight.w900,
                          color: nameIsTap ? Colors.white : Colors.black,
                          fontSize: ScreenUtil().setSp(20),
                          fontFamily: 'myFont'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.h, bottom: 30.h),
              height: 1.h,
              width: 300.w,
              color: Colors.transparent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "输入",
                  style: ThemeFonts.titleFont,
                ),
                Text(
                  "ID",
                  style: ThemeFonts.titleFont,
                ),
                Text(
                  "绑定你的小伙伴",
                  style: ThemeFonts.titleFont,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: PinCodeTextField(
                // autoDismissKeyboard: false,
                autoFocus: false,
                validator: (value) {
                  return value.trim().length > 4 || value.trim().length == 0
                      ? null
                      : "ID要够5位嗷";
                },
                autoValidate: true,
                dialogConfig: DialogConfig(
                    dialogContent: "要粘贴",
                    dialogTitle: "粘贴",
                    negativeText: "取消",
                    affirmativeText: "粘贴"),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                length: 5,
                obsecureText: false,
                textInputType: TextInputType.number,
                animationType: AnimationType.slide,
                textStyle: TextStyle(
                  fontSize: 20,
                  color: ThemeColors.colorWhite,
                  fontWeight: FontWeight.bold,
                ),
                pinTheme: PinTheme(
                  activeColor: ThemeColors.colorBlack,
                  inactiveColor: ThemeColors.colorBlack,
                  selectedFillColor: ThemeColors.colorTheme,
                  inactiveFillColor: ThemeColors.colorWhite,
                  selectedColor: ThemeColors.colorBlack,
                  activeFillColor: ThemeColors.colorBlack,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  fieldHeight: 50,
                  fieldWidth: 50,
                ),
                animationDuration: Duration(milliseconds: 350),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                onCompleted: (v) {
                  // IMP:  通过ID搜寻用户
                  EasyLoading.show();
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            MyButton(
              "搜索",
              isYellow: false,
              fontSize: 15.sp,
              tapAction: handleSearchBtnClick,
            ),
          ],
        ),
      ),
    );
  }
}
