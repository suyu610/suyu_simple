import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/dao/ChatDao.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:suyu_simple/provider/TableProvider.dart';
import 'package:suyu_simple/tools/RandomUtils.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  int counter = 0;

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  BubbleStyle styleSomebody = BubbleStyle(
    nip: BubbleNip.leftTop,
    color: ThemeColors.colorTheme,
    shadowColor: Colors.transparent,
    elevation: 10,
    margin: BubbleEdges.only(top: 8.0, right: 40.0),
    alignment: Alignment.topLeft,
  );

  BubbleStyle styleMe = BubbleStyle(
    nip: BubbleNip.rightBottom,
    color: Colors.red[50],
    elevation: 0,
    margin: BubbleEdges.only(top: 8.0, left: 40.0),
    alignment: Alignment.topRight,
  );

  Future insertMessage() async {
    print("*******************获取数据前*******************");
    print(cacheMsgList);

    int randomDirect = RandomUtil.numberScope(0, 2);
    print("方向是" + randomDirect.toString());

    ChatDAO dao = new ChatDAO();
    //定义实体
    ChatMessage msg = new ChatMessage(
      id: "001",
      content: RandomUtil.getRandomStrNoMoreThan_zh(25),
      createID: "1001",
      createTime: "2020-11-2 15:49:03",
      // type: MsgType.Text,
      isSend: 1,
      direct: randomDirect,
      createName: RandomUtil.getRandomStrNoMoreThan_zh(3),
    );

    int i = await dao.insert(msg);

    print("插入数据成功：$i");

    print(cacheMsgList);

    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    counter++;

    cacheMsgList = <ChatMessage>[]
      ..addAll(cacheMsgList.reversed.toList())
      ..add(msg);
    cacheMsgList = cacheMsgList.reversed.toList();
    print("*******************Counter*******************");

    print(counter);
  }

  //删除所有数据
  Future deleteAllMsg() async {
    //初始化DAO
    ChatDAO dao = new ChatDAO();
    dao.deleteAllMsg();
    setState(() {});
  }

  List<ChatMessage> cacheMsgList;

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh');
      setState(() {});
    });
  }

  ScrollController _listViewScrollController = new ScrollController();

  void _scrollToBottom() {
    // _listViewScrollController.animateTo(
    //     _listViewScrollController.position.minScrollExtent,
    //     duration: const Duration(milliseconds: 400),
    //     curve: Curves.easeOut);
  }

  @override
  void initState() {
    super.initState();
    // cacheMsgList.add(value)
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.merge(
                new Border(
                    left: BorderSide(color: Colors.transparent, width: 0)),
                new Border(bottom: BorderSide(color: Colors.black, width: 5)),
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: _scrollToBottom,
                        child: Text("滚到最后面"),
                      ),
                      FlatButton(
                        onPressed: insertMessage,
                        child: Text("插入一条数据"),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {},
                      child: Text("获取数据"),
                    ),
                    FlatButton(
                      onPressed: deleteAllMsg,
                      child: Text("删除所有数据"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: FutureBuilder<List<ChatMessage>>(
              future: queryMessages(),
              //当网络不可用时，使用缓存数据
              initialData: cacheMsgList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChatMessage>> snapshot) {
                // 请求已结束
                // snapshot.connectionState == ConnectionState.waiting
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
                      height: 473.h,
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: Expanded(
                            child: RefreshIndicator(
                              onRefresh: _onRefresh,
                              backgroundColor: ThemeColors.colorTheme,
                              color: ThemeColors.colorBlack,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                    accentColor: ThemeColors.colorWhite),
                                child: AnimatedList(
                                    reverse: true,
                                    key: listKey,
                                    //插到最前面
                                    controller: _listViewScrollController,
                                    padding: EdgeInsets.all(0),
                                    //添加分割线
                                    initialItemCount: cacheMsgList
                                        .length, //snapshot.data.length,
                                    itemBuilder: (context, index, animation) {
                                      return slideIt(context, index, animation);
                                    }),
                              ),
                            ),
                          ))
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

  Widget slideIt(BuildContext context, int index, animation) {
    ChatMessage item = cacheMsgList[index];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: ListTile(
          leading: item.direct == 0
              ? null
              : Container(
                  height: 35.w,
                  width: 35.w,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(20.w),
                      color: ThemeColors.colorTheme),
                  child: Icon(Icons.face, color: ThemeColors.colorBlack)),
          trailing: item.direct != 0
              ? null
              : Container(
                  height: 35.w,
                  width: 35.w,
                  padding: EdgeInsets.all(9.w),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(20.w),
                    color: ThemeColors.colorWhite,
                  ),
                  child: Image.asset(
                    "assets/images/girl.png",
                  )),
          title: Bubble(
            style: item.direct == 0 ? styleMe : styleSomebody, //:,
            child: Text('${item.createName} : ${item.content}'),
          )),
    );
  }

  Future<List<ChatMessage>> queryMessages() async {
    try {
      cacheMsgList = await Provider.of<TableProvide>(context).getTableInfo();
    } catch (e) {
      print(e.message);
    }

    return cacheMsgList;
  }
}
