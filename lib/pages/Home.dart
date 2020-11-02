import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/Components/Tabbar.dart';
import 'package:suyu_simple/pages/Chat.dart';
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
  static List<StatefulWidget> _widgetOptions = <StatefulWidget>[
    MarkPage(),
    RulePage(),
    ChatPage(),
    HistoryPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions
            .elementAt(Provider.of<TabbarProvider>(context).currentIndex),
      ),
      bottomNavigationBar: TabbarComponent(),
    );
  }
}
