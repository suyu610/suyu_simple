import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/Components/TabBar.dart';
import 'package:suyu_simple/pages/History.dart';
import 'package:suyu_simple/pages/Mark.dart';
import 'package:suyu_simple/pages/Profile.dart';
import 'package:suyu_simple/pages/Rule.dart';
import 'package:suyu_simple/provider/DailyMarkProvider.dart';
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
    return MultiProvider(
        providers: [
          ListenableProvider<DailyMarkProvider>(
              create: (_) => DailyMarkProvider()),
          ListenableProvider<TabbarProvider>(create: (_) => TabbarProvider()),
        ],
        child: MaterialApp(
          builder: BotToastInit(), //1.调用BotToastInit
          navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
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
