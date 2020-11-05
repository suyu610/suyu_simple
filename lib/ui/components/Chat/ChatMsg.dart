import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:popup_menu/popup_menu.dart';

import 'package:suyu_simple/model/MsgType.dart';
import 'package:full_screen_image/full_screen_image.dart';

PopupMenu menu = PopupMenu(
  items: [
    MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
    MenuItem(
        title: 'Home',
        image: Icon(
          Icons.home,
          color: Colors.white,
        )),
    MenuItem(
        title: 'Mail',
        image: Icon(
          Icons.mail,
          color: Colors.white,
        )),
    MenuItem(
        title: 'Power',
        image: Icon(
          Icons.power,
          color: Colors.white,
        )),
    MenuItem(
        title: 'Setting',
        image: Icon(
          Icons.settings,
          color: Colors.white,
        )),
    MenuItem(
        title: 'Traffic',
        image: Icon(
          Icons.traffic,
          color: Colors.white,
        ))
  ],
);

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
    return GestureDetector(
      onLongPress: () => showModalBottomSheet(
          context: context,
          elevation: 0,
          backgroundColor: Theme.of(context).errorColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          builder: (BuildContext context) {
            return SafeArea(
                child: Container(
              height: 50.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () => {},
                  ),
                  Text(
                    "删除",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ));
          }),
      child: Container(
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
                        child: Center(
                        child: Hero(
                          transitionOnUserGestures: true,
                          tag: item.hashCode,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: GestureDetector(
                              child: Image.file(
                                File(item.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      )))),
      ),
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
