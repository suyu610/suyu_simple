import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/provider/TabbarProvider.dart';

class TabbarComponent extends StatefulWidget {
  TabbarComponent({Key key}) : super(key: key);
  @override
  _TabbarComponentState createState() => _TabbarComponentState();
}

class _TabbarComponentState extends State<TabbarComponent> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: GNav(
              gap: 8,
              activeColor: Colors.black,
              color: ThemeColors.colorDDDDDD,
              iconSize: 16.sp,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: themeData.buttonColor,
              tabs: [
                GButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  icon: Ionicons.home_outline,
                  text: '评分',
                  textStyle: TextStyle(fontSize: 12.sp, fontFamily: 'myFont'),
                ),
                GButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    icon: Ionicons.flower_outline,
                    text: '仓库',
                    textStyle:
                        TextStyle(fontSize: 12.sp, fontFamily: 'myFont')),
                GButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    icon: Ionicons.chatbubble_outline,
                    text: '聊天',
                    textStyle:
                        TextStyle(fontSize: 12.sp, fontFamily: 'myFont')),
                GButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    icon: Ionicons.analytics_outline,
                    text: '数据',
                    textStyle:
                        TextStyle(fontSize: 12.sp, fontFamily: 'myFont')),
                GButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(39)),
                    icon: Ionicons.person_outline,
                    text: '我的',
                    textStyle:
                        TextStyle(fontSize: 12.sp, fontFamily: 'myFont')),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                print(index);
                if (_selectedIndex != index) {
                  Provider.of<TabbarProvider>(context, listen: false)
                      .changeIndex(index);
                  setState(() {
                    _selectedIndex = index;
                  });
                }
              }),
        ),
      ),
    );
  }
}
