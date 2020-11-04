import 'package:flutter/cupertino.dart';
import 'package:suyu_simple/dao/ChatDao.dart';
import 'package:suyu_simple/model/ChatMessage.dart';

class TableProvide with ChangeNotifier {
  List<ChatMessage> list = []; //后端json中的key值

  Future getTableInfo() async {
    list.clear();
    list = new List<ChatMessage>();
    //初始化DAO
    ChatDAO dao = new ChatDAO();
    //根据ID查询数据
    List<ChatMessage> msgList = await dao.getMessageList();
    if (msgList != null) {
      list = msgList.reversed.toList();
    } else {}
    Future.delayed(Duration(seconds: 1), () {});
    return list;
  }

  insertNewMsg(ChatMessage msg) {
    ChatDAO dao = new ChatDAO();
    dao.insert(msg);
  }

  deleteAllMsg() {
    //初始化DAO
    ChatDAO dao = new ChatDAO();
    dao.deleteAllMsg();
  }
}
