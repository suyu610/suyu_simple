import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
import 'package:suyu_simple/tools/StrUtil.dart';
import 'package:suyu_simple/ui/components/MyButton.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController textEditingController = new TextEditingController();
  TextEditingController _commentsController = new TextEditingController();

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

    // showAboutDialog(context: context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
        EasyLoading.dismiss();
      },
      child: Container(
        decoration: ThemeFonts.lineBoxDecoration,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Hero(
                    tag: "logo",
                    child: RaisedButton(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Icon(Icons.flash_on),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8.0)), //this right here
                                child: Container(
                                  height: 400,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    border: Border.all(width: 3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Hero(
                                              tag: "logo",
                                              child: SizedBox(
                                                  width: 30.h,
                                                  child: Icon(Icons.flash_on)),
                                            ),
                                            Text(
                                              "素语评分",
                                              style: ThemeFonts.titleFont,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "v0.2",
                                          style: TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          "一个用来学习flutter的小玩具",
                                          style: ThemeFonts.bodyFont,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        // Container(
                                        //   height: 1,
                                        //   width: 375,
                                        //   color: Colors.black12,
                                        // ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          height: 40.h,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.merge(
                                              new Border(
                                                  top: BorderSide(
                                                      color: nameIsTap
                                                          ? ThemeColors
                                                              .colorTheme
                                                          : Colors.transparent,
                                                      width: 3)),
                                              new Border(
                                                  bottom: BorderSide(
                                                      color: nameIsTap
                                                          ? ThemeColors
                                                              .colorTheme
                                                          : Colors.transparent,
                                                      width: 3)),
                                            ),
                                          ),
                                          child: TextField(
                                            controller: _commentsController,
                                            textInputAction:
                                                TextInputAction.done,
                                            onEditingComplete: () =>
                                                print("ok"),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                hintText: '想对我说点什么吗?'),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: FlatButton(
                                            onPressed: () {},
                                            child: Text(
                                              "查看详细介绍",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "你的ID是",
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(20),
                        fontFamily: Provider.of<FontFamilyProvider>(context)
                            .fontFamily),
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
                        boxShadow: [
                          new BoxShadow(
                              color: Color.fromRGBO(173, 179, 191, 0.3),
                              blurRadius: 1.0,
                              offset: new Offset(0, 0))
                        ],
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
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "输入ID绑定你的小伙伴",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: ScreenUtil().setSp(20),
                            fontFamily: Provider.of<FontFamilyProvider>(context)
                                .fontFamily),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 40, right: 40),
                    child: PinCodeTextField(
                      showCursor: false,
                      appContext: context,
                      // autoDismissKeyboard: false,
                      autoFocus: false,
                      validator: (value) {
                        return value.trim().length > 4 ||
                                value.trim().length == 0
                            ? null
                            : "ID要够5位嗷";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      dialogConfig: DialogConfig(
                          dialogContent: "要粘贴",
                          dialogTitle: "粘贴",
                          negativeText: "取消",
                          affirmativeText: "粘贴"),
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow()
                      ],
                      length: 5,
                      obscureText: false,
                      keyboardType: TextInputType.number,
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
                ],
              ),
              MyButton(
                "搜索",
                isYellow: false,
                fontSize: 15.sp,
                tapAction: handleSearchBtnClick,
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
