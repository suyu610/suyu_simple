import 'dart:async';

// import 'package:dio/dio.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:suyu_simple/dao/ChatDao.dart';
import 'package:suyu_simple/tools/RandomUtils.dart';

import 'package:web_socket_channel/io.dart';
// import 'package:suyu_simple/model/ChatMessage.dart';
// import 'package:suyu_simple/provider/ChatProvider.dart';

class ChatStream {
//单例模式
  BuildContext context;
// 工厂模式
  factory ChatStream() => _getInstance();

  static ChatStream get instance => _getInstance();

  StreamSink get sink => _chatMsgStreamController.sink;

  IOWebSocketChannel webSocketChannel;

  static ChatStream _instance;
  StreamController<dynamic> _chatMsgStreamController;

  ChatStream._internal() {
    final String userName =
        RandomUtil.getRandomStrNoMoreThan(RandomUtil.numberScope(4, 11));
    print("用户名是$userName");
    webSocketChannel = new IOWebSocketChannel.connect(
        'ws://62.234.61.19:9090/websocket/$userName');

    // 初始化
    _chatMsgStreamController = StreamController.broadcast();

    ChatDAO chatDAO = new ChatDAO();

    _chatMsgStreamController.sink
        // 从本地获取历史消息
        .addStream(Stream.fromFuture(chatDAO.getMessageList()))
        .then((value) =>
            // 从websoket持续获取
            webSocketChannel.stream.transform(
                StreamTransformer<dynamic, dynamic>.fromHandlers(
                    handleData: (dynamic data, EventSink<dynamic> sink) {
              if (data.runtimeType == String) {
                print("收到一条字符串" + data);
                _chatMsgStreamController.sink.add(
                  data,
                );
              }
            })).listen((event) {
              print("接收到新的消息： " + event);
            }));

    // IMP: 从http获取最新的消息
  }

  IOWebSocketChannel get websocket => webSocketChannel;

  void add() {
    // _chatMsgStreamController.sink.add("newMsg");
  }

  void dispose(filename) {
    _chatMsgStreamController.close();
  }

  Stream getStream({BuildContext context}) {
    this.context = context;
    return this._chatMsgStreamController.stream;
  }

  StreamController getStreamController() {
    return this._chatMsgStreamController;
  }

  static ChatStream _getInstance() {
    if (_instance == null) {
      _instance = new ChatStream._internal();
    }
    return _instance;
  }
}
