// import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:suyu_simple/data/ChatStream.dart';
// import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:suyu_simple/provider/ChatProvider.dart';
import 'package:suyu_simple/tools/DioUtils.dart';

class RulePage extends StatefulWidget {
  RulePage({Key key}) : super(key: key);

  @override
  _RulePageState createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  final TextEditingController inputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print("初始化");
  }

  @override
  void deactivate() {
    super.deactivate();

    print("离开");
  }

  @override
  void dispose() {
    super.dispose();

    inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 100,
            child: AnimatedList(
              initialItemCount:
                  Provider.of<ChatProvider>(context, listen: false)
                      .getTmpList()
                      .length,
              itemBuilder: (context, index, animation) {
                return Text(Provider.of<ChatProvider>(context, listen: false)
                    .getTmpList()
                    .toString());
              },
            ),
          ),
          TextField(
            controller: inputController,
          ),
          RaisedButton(
              child: Text("发送"),
              onPressed: () => DioUtils.request(
                  "https://interface.meiriyiwen.com//article/random",
                  method: DioUtils.GET)),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => print("1"),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
