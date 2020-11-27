import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:suyu_simple/constant/MyTheme.dart';
import 'package:suyu_simple/net/api.dart';
import 'package:suyu_simple/provider/ChatProvider.dart';
import 'package:suyu_simple/provider/DailyMarkProvider.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';
import 'package:suyu_simple/provider/TabbarProvider.dart';
import 'package:suyu_simple/provider/ThemeProvider.dart';
import 'package:suyu_simple/provider/UserPictureProvider.dart';
import 'package:suyu_simple/provider/UserProvider.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => Api()),
  ListenableProvider<UserPictureProvider>(create: (_) => UserPictureProvider()),
  ListenableProvider<UserProvider>(create: (_) => UserProvider()),
  ListenableProvider<FontFamilyProvider>(create: (_) => FontFamilyProvider()),
  ListenableProvider<ThemeProvider>(create: (_) => ThemeProvider(lightTheme)),
  ListenableProvider<ChatProvider>(create: (_) => ChatProvider()),
  ListenableProvider<DailyMarkProvider>(create: (_) => DailyMarkProvider()),
  ListenableProvider<TabbarProvider>(create: (_) => TabbarProvider()),
];

List<SingleChildWidget> dependentServices = [
  //这里使用ProxyProvider来定义需要依赖其他Provider的服务
];
