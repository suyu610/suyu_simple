import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: ThemeColors.colorBlack,
      color: Colors.grey[900],
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon(
            //   Icons.flash_on,
            //   size: 30.sp,
            // ),
            Text("隐藏功能",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: "myFont",
                    color: Colors.white)),
            SizedBox(
              width: 100.w,
              height: 200.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.game_controller_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "玩游戏",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.images_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "相册",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.musical_note_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "唱歌",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.radio_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "提建议",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "logo",
                  child: RaisedButton(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Text(
                        "about me",
                        style: TextStyle(
                          fontFamily: "kaitiFont",
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                height: 200.h,
                                decoration: BoxDecoration(
                                  color: ThemeColors.colorTheme,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.elliptical(85, 23),
                                    topRight: Radius.elliptical(50, 88),
                                    bottomRight: Radius.elliptical(90, 29),
                                    bottomLeft: Radius.elliptical(50, 92),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "嘿~你好呀",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          })),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
