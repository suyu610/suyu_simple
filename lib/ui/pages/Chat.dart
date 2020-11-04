import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:suyu_simple/ui/components/Chat/ChatBar.dart';
import 'package:suyu_simple/ui/components/Chat/ChatMsg.dart';
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
  @override
  void initState() {
    super.initState();
    cacheMsgList = List<ChatMessage>();
  }

  void handle(msg) {
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

  Future _userAddImg(File img) async {
    // 将相片存到本地
    // 获取本地链接
    //定义实体
    RandomUtil.getRandomMsgPicWithPic(img).then((msg) => handle(msg));
  }

  Future _userInsertTextMsg(String text) async {
    if (text == "" || text == null) {
      EasyLoading.showError("不能发空消息");
      return;
    }
    //定义实体
    ChatMessage msg = RandomUtil.getUserRandomMsg(text);

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
    _textFieldController.clear();
  }

  //删除所有数据
  Future deleteAllMsg() async {
    Provider.of<TableProvide>(context, listen: false).deleteAllMsg();
    setState(() {});
  }

  List<ChatMessage> cacheMsgList;

  Future _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 300), () {
      setState(() {});
    });
  }

  void openImagePicker() {}

  ScrollController _listViewScrollController = new ScrollController();

  void _scrollToBottom() {
    _listViewScrollController.animateTo(
        _listViewScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut);
  }

  Future<List<ChatMessage>> queryMessages() async {
    try {
      Provider.of<TableProvide>(context, listen: false)
          .getTableInfo()
          .then((value) => cacheMsgList = value);
    } catch (e) {
      print(e.message);
    }
    return cacheMsgList;
  }

  TextEditingController _textFieldController = new TextEditingController();

  //相册/////////////
  PickedFile _imageFile;
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  String _retrieveDataError;

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
        imageQuality: 50,
      );
      setState(() {
        _imageFile = pickedFile;
        _handlePickImage();
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  String _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      _retrieveDataError = null;
      return _retrieveDataError;
    }
    return null;
  }

  void _handlePickImage() {
    String err = _getRetrieveErrorWidget();
    //如果不为空，则发生错误
    if (err != null) {
      EasyLoading.show(status: err);
      // return ;
    }
    print(_imageFile.path);

    if (_imageFile != null) {
      _userAddImg(File(_imageFile.path));
    } else if (_pickImageError != null) {
      EasyLoading.show(status: "发生不明错误");
    } else {
      EasyLoading.show(status: "没选择照片?");
    }
  }
  //相册/////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatBar(),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
          EasyLoading.dismiss();
        },
        child: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(5.h, 10, 10, 65.h),
            child: FutureBuilder<List<ChatMessage>>(
              future: queryMessages(),
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
                    return Column(
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
                                  initialItemCount: cacheMsgList?.length ??
                                      0, //snapshot.data.length,
                                  itemBuilder: (context, index, animation) {
                                    return slideIt(context, index, animation,
                                        cacheMsgList);
                                  }),
                            ),
                          ),
                        ))
                      ],
                    );
                  }
                } else {
                  // 请求未结束，显示loading
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: ThemeColors.colorTheme,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        ThemeColors.colorBlack),
                  ));
                }
              },
            ),
          ),
          //底部的
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              height: 50.h,
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                    },
                    child: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          // color: ThemeColors.colorTheme,
                          // border: Border.all(width: 2),
                          // borderRadius: BorderRadius.circular(30),
                          ),
                      child: Icon(
                        Icons.image,
                        color: ThemeColors.colorBlack,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),

                  //拍照按钮
                  GestureDetector(
                    onTap: () {
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                    },
                    child: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          // color: ThemeColors.colorTheme,
                          // border: Border.all(width: 2),
                          // borderRadius: BorderRadius.circular(30),
                          ),
                      child: Icon(
                        Icons.photo_camera,
                        color: ThemeColors.colorBlack,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 25, maxWidth: 200),
                      child: TextField(
                        textInputAction: TextInputAction.send,
                        onEditingComplete: () {
                          // 这里进行事件处理
                          _userInsertTextMsg(_textFieldController.text);
                        },
                        controller: _textFieldController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.colorBlack, width: 3),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: ThemeColors.colorTheme, width: 3),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: ThemeFonts.bodyFont,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),

                  //发送按钮
                  GestureDetector(
                    onTap: () {
                      _userInsertTextMsg(_textFieldController.text);
                    },
                    child: Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                          // color: ThemeColors.colorTheme,
                          // borderRadius: BorderRadius.circular(5.h),
                          ),
                      child: Icon(
                        Icons.send,
                        color: ThemeColors.colorBlack,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
