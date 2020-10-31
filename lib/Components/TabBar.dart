import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
    return ChangeNotifierProvider(
        create: (_) => TabbarProvider(),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: Colors.black,
                  color: ThemeColors.colorDDDDDD,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: ThemeColors.colorTheme,
                  tabs: [
                    GButton(
                      icon: Icons.playlist_add_check,
                      text: '评分',
                    ),
                    GButton(
                      icon: Icons.today,
                      text: '规则',
                    ),
                    GButton(
                      icon: Icons.alarm,
                      text: '历史',
                    ),
                    GButton(
                      icon: Icons.account_circle,
                      text: '我的',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    Provider.of<TabbarProvider>(context, listen: false)
                        .changeIndex(index);
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          ),
        ));
  }
}
