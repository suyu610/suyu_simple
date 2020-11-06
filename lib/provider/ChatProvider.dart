import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:suyu_simple/dao/ChatDao.dart';
import 'package:suyu_simple/data/ChatStream.dart';
import 'package:suyu_simple/model/ChatMessage.dart';

class ChatProvider with ChangeNotifier {
  List<dynamic> _list;

  //stream类型的list
  List<dynamic> getTmpList() => _list;

  Stream streamList = ChatStream.instance.getStream();

  sendNewMsg(dynamic msg) async {
    //给socket发送命令

    if (msg is ChatMessage && msg.content != null) {
      //如果是服务器传过来的，就不要再发送了。
      //如果是自己发的，则需要再发送
      //自己的为0

      if (msg.direct != 1) {
        ChatStream.instance.websocket.sink.add(msg.content);

        // IMP:传输图片
        // final myFile = File('file.txt');
        // final bytes = await myFile.readAsBytes();

        // ChatStream.instance.websocket.sink.add(bytes);

      }
    }

    this._list.insert(0, msg);
    ChatDAO dao = new ChatDAO();
    await dao.insert(msg);
  }

  GlobalKey<AnimatedListState> _listKey;

  GlobalKey<AnimatedListState> getListKey() => _listKey;

  void setListKey(GlobalKey<AnimatedListState> listKey) {
    _listKey = listKey;
  }

  void initList(dynamic newList) {
    print(newList.runtimeType);
    if (newList == null) {
      _list = List<ChatMessage>();
      print("空白数据");
      EasyLoading.showToast("成功连接服务器!!!!!!!",
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
    }

    if (newList is List) {
      _list = newList;
      print("有数据");
    } else {
      EasyLoading.showToast("成功连接服务器!!!!!!!",
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  deleteAllMsg() async {
    for (var i = 0; i <= _list.length - 1; i++) {
      _listKey.currentState.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return Container();
      });
    }

    this._list.clear();

    //初始化DAO
    ChatDAO dao = new ChatDAO();
    await dao.deleteAllMsg();
  }
}
