import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RulePage extends StatefulWidget {
  RulePage({Key key}) : super(key: key);

  @override
  _RulePageState createState() => _RulePageState();
}

class _RulePageState extends State<RulePage> {
  final TextEditingController inputController = TextEditingController();

  StreamController<int> _counterStreamController = StreamController<int>(
    onCancel: () {
      print('cancel');
    },
    onListen: () {
      print('listen');
    },
  );

  int _counter = 0;
  Stream _counterStream;
  StreamSink _counterSink;

  // 使用 StreamSink 向 Stream 发送事件，当 _counter 大于 9 时调用 close 方法关闭流。
  void _incrementCounter() {
    if (_counter > 9) {
      _counterSink.close();
      return;
    }
    _counter++;
    _counterSink.add(_counter);
  }

  // 主动关闭流
  void _closeStream() {
    _counterStreamController.close();
  }

  @override
  void initState() {
    super.initState();
    _counterSink = _counterStreamController.sink;
    _counterStream = _counterStreamController.stream;
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    _counterSink.close();
    _counterStreamController.close();
    inputController.dispose();
  }

  Stream<int> countStream(int to) async* {
    for (int i = 1; i <= to; i++) {
      if (i == 4) {
        throw new Exception('Intentional exception');
      } else {
        yield i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          StreamBuilder<int>(
            stream: _counterStream,
            initialData: _counter,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  'Done',
                  style: Theme.of(context).textTheme.bodyText2,
                );
              }
              int number = snapshot.data;
              return Text(
                '$number',
                style: Theme.of(context).textTheme.bodyText2,
              );
            },
          ),
          TextField(
            controller: inputController,
          ),
          RaisedButton(onPressed: () => {}),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.star),
          ),
          SizedBox(height: 24.0),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Close',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 24.0),
          FloatingActionButton(
            onPressed: _closeStream,
            tooltip: 'Close',
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
