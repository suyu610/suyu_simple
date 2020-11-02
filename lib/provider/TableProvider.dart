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

  Future insertMessage() async {
    //初始化DAO
    ChatDAO dao = new ChatDAO();
    //定义实体
    ChatMessage msg = new ChatMessage(
      id: "001",
      content: "插入数据库的测试数据",
      createID: "1001",
      createTime: "2020-11-2 15:49:03",
      // type: MsgType.Text,
      isSend: 1,
      direct: 1,
    );
    int i = await dao.insert(msg);
    print("插入数据成功：$i");
  }
}
