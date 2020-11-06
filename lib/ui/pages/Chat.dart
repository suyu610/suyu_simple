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
// import 'package:suyu_simple/ui/components/Chat/ChatMsg.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:suyu_simple/provider/ChatProvider.dart';
import 'package:suyu_simple/tools/RandomUtils.dart';
import 'package:suyu_simple/ui/components/Chat/ChatMsg.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).setListKey(_listKey);
  }

  void handle(msg) async {
    Provider.of<ChatProvider>(context, listen: false).sendNewMsg(msg);

    _listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));

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

  // from 0 自己的
  // from 1 别人的

  Future _userInsertTextMsg(String text, int from) async {
    if (text == "" || text == null) {
      EasyLoading.showError("不能发空消息");
      return;
    }

    //定义实体

    ChatMessage msg = RandomUtil.getUserRandomMsg(text, from);

    //保存在provider的list中
    Provider.of<ChatProvider>(context, listen: false).sendNewMsg(msg);

    _listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));

    // 滚动到最底下
    if (_listViewScrollController.offset !=
        _listViewScrollController.position.maxScrollExtent) {
      _scrollToBottom();
    }

    _textFieldController.clear();
  }

  Future _onRefresh() async {
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

    if (_imageFile != null) {
      _userAddImg(File(_imageFile.path));
    } else if (_pickImageError != null) {
      EasyLoading.show(status: "发生不明错误");
    } else {
      EasyLoading.show(status: "没选择照片?");
    }
  }

  ////////////相册/////////////

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
            child: StreamBuilder(
                stream: Provider.of<ChatProvider>(context).streamList,
                initialData: Provider.of<ChatProvider>(context).getTmpList(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("--------CHAT----------");
                    print(snapshot.data);

                    if (snapshot.data.runtimeType == String) {
                      _userInsertTextMsg(snapshot.data, 1);
                    }

                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      backgroundColor: ThemeColors.colorTheme,
                      color: ThemeColors.colorBlack,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(accentColor: ThemeColors.colorWhite),
                        child: AnimatedList(
                            reverse: true,
                            key: _listKey,
                            //插到最前面
                            controller: _listViewScrollController,
                            padding: EdgeInsets.all(0),
                            //添加分割线
                            initialItemCount: Provider.of<ChatProvider>(context,
                                    listen: false)
                                .getTmpList()
                                .length,
                            itemBuilder: (context, index, animation) {
                              return ChatMsg(
                                  context,
                                  index,
                                  animation,
                                  Provider.of<ChatProvider>(context,
                                          listen: false)
                                      .getTmpList());
                            }),
                      ),
                    );
                  } else {
                    return Text("无数据");
                  }
                }),
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
                          _userInsertTextMsg(_textFieldController.text, 0);
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
                      _userInsertTextMsg(_textFieldController.text, 0);
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
