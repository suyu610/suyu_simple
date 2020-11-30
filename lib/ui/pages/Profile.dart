import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/widgets.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/constant/theme_fonts.dart';
import 'package:suyu_simple/provider/font_family_provider.dart';
import 'package:suyu_simple/provider/user_provider.dart';
import 'package:suyu_simple/ui/components/about_dialog.dart';
import 'package:suyu_simple/ui/components/draggable_card.dart';
import 'package:suyu_simple/ui/components/my_button.dart';
import 'package:suyu_simple/viewmodels/profile_viewmodel.dart';

import '../base_view.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  var errorController;

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).viewInsets.bottom * 0.8);
    // showAboutDialog
    return BaseView<ProfileViewModel>(
        // 初始化
        onModelReady: (model) async {
          model.initState();
        },
        model: ProfileViewModel(Provider.of(context), context),
        builder: (context, model, child) {
          return _buildMain(context, model);
        });
  }

  Widget _buildMain(BuildContext context, ProfileViewModel model) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
        EasyLoading.dismiss();
      },
      child: SafeArea(
        child: Container(
          decoration: ThemeFonts.lineBoxDecoration,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 0,
                child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MyAboutDialog();
                        })),
              ),
              Container(
                width: 375.w,
                margin: EdgeInsets.only(top: 52.h),
                child: Column(
                  children: [
                    Visibility(
                      visible: !model.hasFriend,
                      child: _buildHasNoFriendAvatarView(context, model),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    _buildIdView(context, model),
                    SizedBox(
                      height: 30.h,
                    ),
                    Visibility(
                      visible: model.hasFriend,
                      child: _buildHasFriendAvatarView(context, model),
                    ),
                  ],
                ),
              ),
              _buildSecretMsg(context, model),
              _buildSearchView(context, model),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdView(BuildContext context, ProfileViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Text(
        //   "你的ID是",
        //   style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        // ),
        SizedBox(
          height: 15.h,
        ),
        GestureDetector(
          onTap: model.handleNameTap,
          child: Container(
            width: 150.w,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Color.fromRGBO(254, 212, 91, 1),
              boxShadow: [
                new BoxShadow(
                    color: Color.fromRGBO(173, 179, 191, 0.3),
                    blurRadius: 1.0,
                    offset: new Offset(0, 0))
              ],
              border: Border.merge(
                new Border(left: BorderSide(color: Colors.black, width: 5)),
                new Border(right: BorderSide(color: Colors.black, width: 5)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.face,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                ),
                Text(
                  Provider.of<UserProvider>(context).getUser().id,
                  style: TextStyle(
                      letterSpacing: 5.w,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(20),
                      fontFamily: 'myFont'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHasNoFriendAvatarView(
      BuildContext context, ProfileViewModel model) {
    return Center(
        child: CircularProfileAvatar(
      '',
      placeHolder: (context, url) => Container(
        width: 35.h,
        height: 35.h,
        child: CircularProgressIndicator(),
      ),
      child: Container(
        margin: const EdgeInsets.all(0.0),
        child: Image(
          image: AssetImage("assets/images/girl.png"),
        ),
      ),
      radius: 24.h,
      backgroundColor: Colors.white,
      borderWidth: 3,
      borderColor: Colors.black,
      foregroundColor: Colors.black,
      showInitialTextAbovePicture: false,
      cacheImage: true,
      onTap: () {
        print('adil');
      },
    ));
  }

  Widget _buildHasFriendAvatarView(
      BuildContext context, ProfileViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50.0.w,
          height: 50.0.w,
          decoration: new BoxDecoration(
            color: Colors.transparent,
            image: new DecorationImage(
              // image: AssetImage("assets/images/girl.png"),

              image: new NetworkImage(
                Provider.of<UserProvider>(context, listen: false)
                    .getUser()
                    .faceImageBig,
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
            border: new Border.all(
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        GestureDetector(
          child: Icon(
            Ionicons.heart,
            color: Color(0xffff7471),
            size: 24.sp,
          ),
          onTap: model.handleHeartBtnClick,
        ),
        SizedBox(
          width: 16.w,
        ),
        Icon(
          Icons.face,
          color: Colors.black,
          size: 50.w,
        ),
      ],
    );
  }

  Widget _buildSearchView(BuildContext context, ProfileViewModel model) {
    return Visibility(
      visible: !model.hasFriend,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Divider(
          //   thickness: 5,
          //   height: 2,
          //   indent: 60.w,
          //   endIndent: 60.w,
          //   color: Colors.black,
          // ),
          SizedBox(
            height: 21.h,
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
                        Provider.of<FontFamilyProvider>(context).fontFamily),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
            child: PinCodeTextField(
              showCursor: false,
              appContext: context,
              // autoDismissKeyboard: false,
              autoFocus: false,
              
              validator: (value) {
                return value.trim().length > 4 || value.trim().length == 0
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
                disabledColor: ThemeColors.colorTheme,
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
                  model.currentText = value;
                });
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                return true;
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          MyButton(
            "搜索",
            isYellow: false,
            fontSize: 15.sp,
            tapAction: model.handleSearchBtnClick,
          ),
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 150),
            curve: Curves.fastOutSlowIn,
            child: Container(
              child: Container(
                child: SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom * 0.8 + 50.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecretMsg(BuildContext context, ProfileViewModel model) {
    return Container(
      width: 375.w,
      child: Visibility(
        visible: model.hasFriend,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.h,
            ),
            // Divider(
            //   thickness: 5,
            //   height: 2,
            //   indent: 60.w,
            //   endIndent: 60.w,
            //   color: Colors.black,
            // ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "悄悄话",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
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
                  width: 130.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.colorTheme,
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "[  ${model.friendName}  ]",
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
    );
  }
}

Widget bottomSheet(BuildContext context, ProfileViewModel model) {
  return Container(
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
            onTap: model.handleExitBtnClick,
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
  );
}
