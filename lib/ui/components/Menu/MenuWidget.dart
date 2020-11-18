import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
import 'package:suyu_simple/ui/components/Menu/MenuItem.dart';

import '../AboutDialog.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MenuItem(
                      title: "玩游戏",
                      icon: Ionicons.game_controller_outline,
                      tapAction: () => {}),
                  MenuItem(
                    title: "相册",
                    icon: Ionicons.images_outline,
                    tapAction: () => print("xixi"),
                  ),
                  MenuItem(
                      title: "唱歌",
                      icon: Ionicons.musical_note_outline,
                      tapAction: () => {}),
                  MenuItem(
                      title: "收藏夹",
                      icon: Ionicons.bookmark_outline,
                      tapAction: () => {}),
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
                    // ignore: dead_code
                    icon: Icon(true ? Ionicons.moon_sharp : Ionicons.sunny),
                    color: Colors.white,
                    onPressed: () => {}),
                IconButton(
                    iconSize: 16.sp,
                    // ignore: dead_code
                    icon: Icon(
                      Ionicons.git_network_outline,
                    ),
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
                            return MyAboutDialog();
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