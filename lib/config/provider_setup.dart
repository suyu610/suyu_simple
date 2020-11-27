import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:suyu_simple/constant/my_theme.dart';
import 'package:suyu_simple/net/api.dart';
import 'package:suyu_simple/provider/chat_provider.dart';
import 'package:suyu_simple/provider/daily_mark_provider.dart';
import 'package:suyu_simple/provider/font_family_provider.dart';
import 'package:suyu_simple/provider/tabbar_provider.dart';
import 'package:suyu_simple/provider/theme_provider.dart';
import 'package:suyu_simple/provider/user_picture_provider.dart';
import 'package:suyu_simple/provider/user_provider.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => Api()),
  ListenableProvider<UserPictureProvider>(create: (_) => UserPictureProvider()),
  ListenableProvider<UserProvider>(create: (_) => UserProvider()),
  ListenableProvider<FontFamilyProvider>(create: (_) => FontFamilyProvider()),
  ListenableProvider<ThemeProvider>(create: (_) => ThemeProvider(LIGHT)),
  ListenableProvider<ChatProvider>(create: (_) => ChatProvider()),
  ListenableProvider<DailyMarkProvider>(create: (_) => DailyMarkProvider()),
  ListenableProvider<TabbarProvider>(create: (_) => TabbarProvider()),
];

List<SingleChildWidget> dependentServices = [
  //这里使用ProxyProvider来定义需要依赖其他Provider的服务
];
