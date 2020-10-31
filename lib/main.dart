import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:suyu_simple/pages/History.dart';
import 'package:suyu_simple/pages/Mark.dart';
import 'package:suyu_simple/pages/Profile.dart';
import 'package:suyu_simple/pages/Rule.dart';


import 'common/ThemeColor.dart';

void main() {
  runApp(MaterialApp(
    title: "GNav",
    theme: ThemeData(
      primaryColor: ThemeColors.colorTheme,
    ),
    home: Main(),
    debugShowCheckedModeBanner: false,
  ));

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent
  ));

}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<StatefulWidget> _widgetOptions = <StatefulWidget>[
    MarkPage(),
    RulePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 8,
                activeColor: Colors.black,
                color:ThemeColors.colorDDDDDD,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 300),
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
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          ),
        ),
      ),
    );
  }
}
