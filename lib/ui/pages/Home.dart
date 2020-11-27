import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:suyu_simple/provider/UserPictureProvider.dart';
import 'package:suyu_simple/tools/SharePreferencesUtils.dart';
import 'package:suyu_simple/ui/Components/Tabbar.dart';
import 'package:suyu_simple/ui/pages/Chat.dart';
import 'package:suyu_simple/provider/TabbarProvider.dart';

import 'History.dart';
import 'Mark.dart';
import 'Profile.dart';
import 'Rule.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<StatefulWidget> _pageList = <StatefulWidget>[
    MarkPage(),
    RulePage(),
    ChatPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    Future<dynamic> sign = SharePreferencesUtils.sign(
      SharePreferencesUtilsWorkType.get,
    );
    sign.then((value) =>
        Provider.of<UserPictureProvider>(context, listen: false).signSvgStr =
            value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList
          .elementAt(Provider.of<TabbarProvider>(context).currentIndex),
      bottomNavigationBar: TabbarComponent(),
    );
  }
}
