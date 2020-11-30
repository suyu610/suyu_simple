import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/config/provider_setup.dart';
import 'package:suyu_simple/provider/theme_provider.dart';
import 'package:suyu_simple/provider/user_provider.dart';
import 'package:suyu_simple/service/background_main.dart';
import 'package:suyu_simple/tools/share_preferences_utils.dart';
import 'package:suyu_simple/ui/pages/Splash.dart';

import 'package:suyu_simple/ui/pages/home.dart';

import 'package:suyu_simple/ui/pages/login.dart';
import 'config/Global.dart';
import 'constant/theme_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Global.init().then((e) => runApp(
    // provider
        MultiProvider(providers: providers, child: MyApp()),
      ));

  var channel = const MethodChannel('life.qdu/background_service');

  var callbackHandle = PluginUtilities.getCallbackHandle(backgroundMain);

  channel.invokeMethod('startService', callbackHandle.toRawHandle());
  // CounterService.instance().startCounting();
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  //第一屏时，需要做的事情
  _costomFunc() {
    isLogin =
        SharePreferencesUtils.user(SharePreferencesUtilsWorkType.get) == null;
    EasyLoading.instance.toastPosition = EasyLoadingToastPosition.bottom;
    Provider.of<UserProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    _costomFunc();
    debugPrint("---------------1--------------");

    final themeNotifier = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
      //启动页面
      home: AnimatedSplash(
        color: ThemeColors.colorTheme,
        duration: 2000,
        // home: FirstGamePage(),
        home: isLogin ? HomePage() : LoginPage(),
      ),

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: EasyLoading.init(),
      supportedLocales: [
        const Locale('zh', 'CH'),
      ],
      locale: Locale('zh'),
      // 当前主体
      theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
