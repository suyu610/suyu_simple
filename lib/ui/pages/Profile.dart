import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/widgets.dart';

import 'package:suyu_simple/constant/ThemeColor.dart';
import 'package:suyu_simple/constant/ThemeFonts.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
import 'package:suyu_simple/provider/UserProvider.dart';
import 'package:suyu_simple/route/RouterHelper.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';
import 'package:suyu_simple/tools/StrUtil.dart';
import 'package:suyu_simple/ui/components/AboutDialog.dart';
import 'package:suyu_simple/ui/components/DraggableCard.dart';
import 'package:suyu_simple/ui/components/MyButton.dart';

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

  bool hasFriend;
  String friendName;
  @override
  void initState() {
    super.initState();

    print("------------");
    print(
      Provider.of<UserProvider>(context, listen: false).getUser().faceImageBig,
    );
    print("------------");
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
  }

  var errorController;
  Future<void> handleResetBtnClick() async {
    await SharePreferencesUtils.token(
      SharePreferencesUtilsWorkType.remove,
    );
    EasyLoading.showSuccess("退出成功");
    RouterHelper.router.navigateTo(context, "/login",
        transition: TransitionType.fadeIn, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    bool nameIsTap = false;
    void handleNameTap() {
      showModalBottomSheet(
          context: context,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          builder: (BuildContext context) {
            return SafeArea(
                child: Container(
              height: 100.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                      child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Ionicons.create_outline,
                          color: Colors.black,
                          size: 28.sp,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "修改信息",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
                  GestureDetector(
                      onTap: handleResetBtnClick,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app_outlined,
                              color: Colors.black,
                              size: 28.sp,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "退出",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ));
          });
      print("按了一下");
      setState(() {
        nameIsTap = !nameIsTap;
        print(nameIsTap);
      });
    }

    // showAboutDialog
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
                              return MyAboutDialog();
                            })),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  // SizedBox(
                  //   height: 10.w,
                  // ),
                  // Text(
                  //   "姓名 : ${Provider.of<UserProvider>(context, listen: false).getUser().nickname}",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       fontSize: ScreenUtil().setSp(20),
                  //       fontFamily: Provider.of<FontFamilyProvider>(context)
                  //           .fontFamily),
                  // ),
                  SizedBox(
                    height: 30.w,
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
                      ),
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
                            Provider.of<UserProvider>(context).getUser().id,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DraggableCard(
                    child: Container(
                      width: 50.0.w,
                      height: 50.0.w,
                      decoration: new BoxDecoration(
                        color: Colors.transparent,
                        image: new DecorationImage(
                          image: AssetImage("assets/images/girl.png"),

                          // new NetworkImage(
                          //   Provider.of<UserProvider>(context, listen: false)
                          //       .getUser()
                          //       .faceImageBig,
                          // ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(30.0)),
                        border: new Border.all(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Icon(
                    Ionicons.heart,
                    color: Color(0xffff7471),
                    size: 24.sp,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  DraggableCard(
                    child: Icon(
                      Icons.face,
                      color: nameIsTap ? Colors.white : Colors.black,
                      size: 50.w,
                    ),
                  ),
                  // new Container(
                  //   width: 40.0.w,
                  //   height: 40.0.w,
                  //   decoration: new BoxDecoration(
                  //     color: Colors.transparent,
                  //     image: new DecorationImage(
                  //       image: AssetImage("assets/images/girl.png"),

                  //       // new NetworkImage(
                  //       //   Provider.of<UserProvider>(context, listen: false)
                  //       //       .getUser()
                  //       //       .faceImageBig,
                  //       // ),
                  //       fit: BoxFit.cover,
                  //     ),
                  //     borderRadius:
                  //         new BorderRadius.all(new Radius.circular(30.0)),
                  //     border: new Border.all(
                  //       color: Colors.transparent,
                  //       width: 0.0,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Visibility(
                visible: hasFriend,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   "他",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: ScreenUtil().setSp(20),
                    //       fontFamily: Provider.of<FontFamilyProvider>(context)
                    //           .fontFamily),
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Scratcher(
                      image: Image.asset('assets/images/lucky.png'),
                      accuracy: ScratchAccuracy.low,
                      brushSize: 15,
                      threshold: 40,
                      color: ThemeColors.colorBlack.withAlpha(230),
                      // onChange: (value) => print("Scratch progress: $value%"),
                      // onThreshold: () => print("Threshold reached, you won!"),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Container(
                          width: 150.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: ThemeColors.colorTheme,
                            // borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "[  $friendName  ]",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: ScreenUtil().setSp(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !hasFriend,
                child: Column(
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
                              fontFamily:
                                  Provider.of<FontFamilyProvider>(context)
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
              ),
              Visibility(
                visible: !hasFriend,
                child: MyButton(
                  "搜索",
                  isYellow: false,
                  fontSize: 15.sp,
                  tapAction: handleSearchBtnClick,
                ),
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
