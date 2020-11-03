import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/components/ChatMsg.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:suyu_simple/model/MsgType.dart';
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
  @override
  void initState() {
    super.initState();
    cacheMsgList = List<ChatMessage>();
  }

  Future _insertMsg(int index) async {
    //定义实体
    ChatMessage msg = index == MsgType.Pic.index
        ? RandomUtil.getRandomMsgPic()
        : RandomUtil.getRandomMsg();

    Provider.of<TableProvide>(context, listen: false).insertNewMsg(msg);

    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    counter++;

    cacheMsgList = <ChatMessage>[]
      ..addAll(cacheMsgList.reversed.toList())
      ..add(msg);
    cacheMsgList = cacheMsgList.reversed.toList();

    // 滚动到最底下
    if (_listViewScrollController.offset !=
        _listViewScrollController.position.maxScrollExtent) {
      _scrollToBottom();
    }
  }

  //删除所有数据
  Future deleteAllMsg() async {
    Provider.of<TableProvide>(context, listen: false).deleteAllMsg();
    setState(() {});
  }

  List<ChatMessage> cacheMsgList;

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 300), () {
      setState(() {});
    });
  }

  ScrollController _listViewScrollController = new ScrollController();

  void _scrollToBottom() {
    _listViewScrollController.animateTo(
        _listViewScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut);
  }

  Future<List<ChatMessage>> queryMessages() async {
    try {
      cacheMsgList = await Provider.of<TableProvide>(context, listen: false)
          .getTableInfo();
    } catch (e) {
      print(e.message);
    }
    return cacheMsgList;
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
                new Border(bottom: BorderSide(color: Colors.black, width: 2)),
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => _insertMsg(MsgType.Pic.index),
                        child: Text("插入一个图片消息"),
                      ),
                      FlatButton(
                        onPressed: () => _insertMsg(MsgType.Text.index),
                        child: Text("插入一条文本消息"),
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: deleteAllMsg,
                      child: Text("删除所有数据"),
                    ),
                    FlatButton(
                      onPressed: _scrollToBottom,
                      child: Text("滚到最后面"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: FutureBuilder<List<ChatMessage>>(
              future: queryMessages(),
              //当网络不可用时，使用缓存数据
              initialData: cacheMsgList,
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
                      height: 520.h,
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
          //让他从底下出来
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: ChatMsg(item));
  }
}
