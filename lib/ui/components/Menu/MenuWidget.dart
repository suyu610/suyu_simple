import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
// import 'package:suyu_simple/common/ThemeFonts.dart';
// import 'package:suyu_simple/provider/FontFamilyProvider.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: ThemeColors.colorBlack,
      color: Colors.grey[900],
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 0.h,
            ),
            Text("隐藏功能",
                style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: "myFont",
                    // fontWeight: FontWeight.bold,
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
                        size: 16.sp,
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
                        size: 16.sp,
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
                        size: 16.sp,
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
                        Ionicons.bookmark_outline,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "收藏夹",
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
                IconButton(
                    iconSize: 16.sp,
                    icon: Provider.of<FontFamilyProvider>(context, listen: true)
                            .isUseCustomFontFamily
                        ? Icon(Ionicons.color_palette_sharp)
                        : Icon(Ionicons.color_palette_outline),
                    color:
                        Provider.of<FontFamilyProvider>(context, listen: true)
                                .isUseCustomFontFamily
                            ? ThemeColors.colorTheme
                            : Colors.white,
                    onPressed: () => {}),
                IconButton(
                    iconSize: 16.sp,
                    icon: Icon(true ? Ionicons.moon_sharp : Ionicons.sunny),
                    color: Colors.white,
                    onPressed: () => {}),
                Hero(
                  tag: "logo",
                  child: IconButton(
                      iconSize: 16.sp,
                      color: Colors.transparent,
                      icon: Icon(
                        Icons.flash_on_sharp,
                        color: Colors.white,
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
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
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
            SizedBox(
              height: 0.h,
            ),
          ],
        ),
      ),
    );
  }
}
