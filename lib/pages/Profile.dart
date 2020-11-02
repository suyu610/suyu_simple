import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/Components/MyButton.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingController = new TextEditingController();
  String currentText;

  var errorController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        decoration: ThemeFonts.lineBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                autoFocus: true,

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
                  // IMP  通过ID搜寻用户

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
              width: 117.w,
              height: 24.h,
              title: "确定",
              isYellow: false,
              fontSize: 15.sp,
              tapAction: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
