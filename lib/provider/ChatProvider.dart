import 'package:flutter/cupertino.dart';
import 'package:suyu_simple/dao/ChatDao.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:suyu_simple/ui/components/Chat/ChatMsg.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _list;

  void updateList(newList) {
    _list.clear();
    this._list = newList;
  }

  List<ChatMessage> getTmpList() => _list;

  Future<List<ChatMessage>> getWholeChatInfoInDatabase() async {
    print("有人请求了");
    this._list.clear();

    //初始化DA
    ChatDAO dao = new ChatDAO();
    //根据ID查询数据
    List<ChatMessage> msgList = await dao.getMessageList();
    print(msgList);
    if (msgList != null) {
      this._list = msgList.reversed.toList();
      print("**************");
      print(_list);
    } else {
      print("没数据");
    }
    return this._list;
  }

  insertNewMsg(ChatMessage msg) {
    this._list.insert(0, msg);
    ChatDAO dao = new ChatDAO();
    dao.insert(msg);
  }

  GlobalKey<AnimatedListState> _listKey;

  GlobalKey<AnimatedListState> getListKey() => _listKey;

  void setListKey(GlobalKey<AnimatedListState> listKey) {
    _listKey = listKey;
  }

  void initList(List<ChatMessage> newList) {
    _list = newList;
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
