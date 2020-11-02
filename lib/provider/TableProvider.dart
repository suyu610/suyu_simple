import 'package:flutter/cupertino.dart';
import 'package:suyu_simple/dao/ChatDao.dart';
import 'package:suyu_simple/model/ChatMessage.dart';

class TableProvide with ChangeNotifier {
  List<ChatMessage> list = []; //后端json中的key值

  getTableInfo() async {
    list.clear();
    //初始化DAO
    ChatDAO dao = new ChatDAO();
    //根据ID查询数据
    List<ChatMessage> msgList = await dao.getMessageList();
    if (msgList != null) {
      list = msgList;
    }
    Future.delayed(Duration(seconds: 1), () {});
    return list;
  }
}
