import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/dao/ChatDao.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:suyu_simple/provider/TableProvider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // List<String> _chatList = [];
  Future insertMessage() async {
    Provider.of<TableProvide>(context, listen: false).insertMessage();
    setState(() {});
  }

  //删除所有数据
  Future deleteAllMsg() async {
    //初始化DAO
    ChatDAO dao = new ChatDAO();
    dao.deleteAllMsg();
    setState(() {});
  }

  Future queryMessageByID() async {
    Provider.of<TableProvide>(context, listen: false).getTableInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text(
            "聊天",
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: insertMessage,
            child: Text("插入一条数据"),
          ),
          FlatButton(
            onPressed: queryMessageByID,
            child: Text("获取数据"),
          ),
          FlatButton(
            onPressed: deleteAllMsg,
            child: Text("删除所有数据"),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: FutureBuilder<List<ChatMessage>>(
              future: queryMessages(),
              //当网络不可用时，使用缓存数据
              initialData: null,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatMessage>> snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Container(
                      height: 60.0,
                      child: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  } else {
                    return Container(
                      height: 300,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ListView.separated(
                                //添加分割线
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return new Divider(
                                    height: 0.3,
                                    color: Colors.lightGreen,
                                  );
                                },
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  ChatMessage c = snapshot.data[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // showConfirmDialog(_list[index]);
                                    },
                                    child: ListTile(title: Text(c.content)),
                                  );
                                }),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  // 请求未结束，显示loading
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ]));
  }

  Future<List<ChatMessage>> queryMessages() async {
    List<ChatMessage> messages;
    try {
      messages = await Provider.of<TableProvide>(context).getTableInfo();
    } catch (e) {
      print(e.message);
    }

    return messages;
  }
}
