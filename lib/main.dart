import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/Components/TabBar.dart';
import 'package:suyu_simple/pages/History.dart';
import 'package:suyu_simple/pages/Mark.dart';
import 'package:suyu_simple/pages/Profile.dart';
import 'package:suyu_simple/pages/Rule.dart';
import 'package:suyu_simple/provider/TabbarProvider.dart';

import 'common/ThemeColor.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TabbarProvider(),
        child: MaterialApp(
          title: 'Material Components',
          theme: ThemeData(
            primaryColor: ThemeColors.colorTheme,
          ),
          home: Main(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  static List<StatefulWidget> _widgetOptions = <StatefulWidget>[
    MarkPage(),
    RulePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(375, 667), allowFontScaling: true);
    return Scaffold(
      body: Center(
        child: _widgetOptions
            .elementAt(Provider.of<TabbarProvider>(context).currentIndex),
      ),
      bottomNavigationBar: TabbarComponent(),
    );
  }
}
