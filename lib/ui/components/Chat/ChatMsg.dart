import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:suyu_simple/model/MsgType.dart';
import 'package:full_screen_image/full_screen_image.dart';

Widget slideIt(BuildContext context, int index, animation,
    List<ChatMessage> cacheMsgList) {
  if (cacheMsgList != null || cacheMsgList.length != 0) {
    ChatMessage item = cacheMsgList[index];
    return SlideTransition(
        position: Tween<Offset>(
          //让他从底下出来
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: ChatMsg(item));
  }
  return null;
}

class ChatMsg extends StatelessWidget {
  const ChatMsg(this.item, {Key key}) : super(key: key);
  final ChatMessage item;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: item.type == MsgType.Text.index
                  ? Text('${item.content}')
                  : FullScreenWidget(
                      child: Hero(
                        tag: item.hashCode,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            File(item.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ))),
    );
  }
}

BubbleStyle styleSomebody = BubbleStyle(
  nip: BubbleNip.leftTop,
  color: ThemeColors.colorTheme,
  shadowColor: Colors.transparent,
  elevation: 10,
  margin: BubbleEdges.only(top: 8.0, right: 40.0),
  alignment: Alignment.topLeft,
);

BubbleStyle styleMe = BubbleStyle(
  nip: BubbleNip.rightTop,
  color: Colors.red[50],
  elevation: 0,
  margin: BubbleEdges.only(top: 8.0, left: 40.0),
  alignment: Alignment.topRight,
);
