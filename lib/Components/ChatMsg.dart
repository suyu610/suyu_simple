import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/model/ChatMessage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/model/MsgType.dart';

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
                : Image.asset(item.path),
          )),
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
  nip: BubbleNip.rightBottom,
  color: Colors.red[50],
  elevation: 0,
  margin: BubbleEdges.only(top: 8.0, left: 40.0),
  alignment: Alignment.topRight,
);
