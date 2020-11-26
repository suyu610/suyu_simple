// import 'dart:async';
// import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:suyu_simple/common/MyTheme.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/net/ChatStream.dart';
// import 'package:suyu_simple/common/ThemeFonts.dart';
// import 'package:suyu_simple/tools/MainUtil.dart';
// import 'package:suyu_simple/ui/pages/Home.dart';
// import 'package:suyu_simple/ui/pages/Login.dart';
import 'package:suyu_simple/provider/DailyMarkProvider.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
import 'package:suyu_simple/provider/TabbarProvider.dart';
import 'package:suyu_simple/provider/ChatProvider.dart';
import 'package:suyu_simple/provider/UserPictureProvider.dart';
import 'package:suyu_simple/provider/UserProvider.dart';
import 'package:suyu_simple/route/RouterConfig.dart';
import 'package:suyu_simple/route/RouterHelper.dart';

import 'package:suyu_simple/tools/InitUtils.dart';
import 'package:suyu_simple/ui/pages/Splash.dart';
import 'package:suyu_simple/ui/pages/Main.dart';

import 'common/Global.dart';
// import 'common/ThemeColor.dart';
import 'provider/ThemeProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Global.init().then((e) => runApp(
        MultiProvider(providers: [
          ListenableProvider<UserPictureProvider>(
              create: (_) => UserPictureProvider()),
          ListenableProvider<UserProvider>(create: (_) => UserProvider()),
          ListenableProvider<FontFamilyProvider>(
              create: (_) => FontFamilyProvider()),
          ListenableProvider<ThemeProvider>(
              create: (_) => ThemeProvider(lightTheme)),
          ListenableProvider<ChatProvider>(create: (_) => ChatProvider()),
          ListenableProvider<DailyMarkProvider>(
              create: (_) => DailyMarkProvider()),
          ListenableProvider<TabbarProvider>(create: (_) => TabbarProvider()),
        ], child: MyApp()),
      ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    RouterConfig.configureRoutes(router);
    RouterHelper.router = router;
  }

  @override
  void initState() {
    super.initState();

    EasyLoading.instance.toastPosition = EasyLoadingToastPosition.bottom;
    precacheImage(Image.asset("assets/images/logo_trans.png").image, context);
    precacheImage(Image.asset("assets/images/logo.png").image, context);
    ChatStream.instance.getStream().listen(
          (data) =>
              Provider.of<ChatProvider>(context, listen: false).initList(data),
        );
    Provider.of<UserProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
      //启动页面
      home: AnimatedSplash(
        color: ThemeColors.colorTheme,
        duration: 2000,
        home: Main(),
      ),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
      locale: Locale('zh'),
      builder: EasyLoadingInit(),
      // 当前主体
      theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
