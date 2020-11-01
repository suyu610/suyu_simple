import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            Text(
              "输入ID，绑定你的小伙伴",
              style: ThemeFonts.titleFont,
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: PinCodeTextField(
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
                  print("Completed");
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
