import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:suyu_simple/constant/ThemeColor.dart';
import 'package:suyu_simple/model/chat_message.dart';

import 'package:suyu_simple/constant/MsgType.dart';
import 'package:suyu_simple/ui/components/Image/FullScreenWidget.dart';

// ignore: non_constant_identifier_names
Widget ChatMsg(BuildContext context, int index, animation,
    List<ChatMessage> cacheMsgList) {
  if (cacheMsgList != null || cacheMsgList.length != 0) {
    ChatMessage item = cacheMsgList[index];
    //如果是图片，则从左右出来
    return SlideTransition(
        position: Tween<Offset>(
          //让他从底下出来
          begin: item.type == MsgType.Pic ? Offset(1, 0) : Offset(0, 1),
          end: const Offset(0, 0),
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: ChatMsgContent(item));
  }
  return null;
}

class ChatMsgContent extends StatelessWidget {
  const ChatMsgContent(this.item, {Key key}) : super(key: key);
  final ChatMessage item;

  @override
  Widget build(BuildContext context) {
    File imageFile;
    if (item.type == MsgType.Pic) {
      imageFile = File(item.localPath);
    }
    return GestureDetector(
        onLongPress: () => showModalBottomSheet(
            context: context,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            builder: (BuildContext context) {
              return SafeArea(
                  child: Container(
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Ionicons.trash_outline,
                        color: Colors.black,
                        size: 28.sp,
                      ),
                    )),
                    GestureDetector(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Ionicons.bookmark_outline,
                        color: Colors.black,
                        size: 28.sp,
                      ),
                    )),
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
              child: item.type == MsgType.Text
                  ? Text('${item.content}')
                  : FullScreenWidget(
                      backgroundColor: Colors.white,
                      child: Hero(
                        tag: imageFile.uri,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ExtendedImage.file(
                            imageFile,
                            fit: BoxFit.contain,
                            //enableLoadState: false,
                            mode: ExtendedImageMode.gesture,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 1.0,
                                animationMinScale: 0.7,
                                maxScale: 3.0,
                                animationMaxScale: 3.5,
                                speed: 1.0,
                                inertialSpeed: 100.0,
                                initialScale: 1.0,
                                inPageView: false,
                                initialAlignment: InitialAlignment.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ));
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen(this.item, {Key key}) : super(key: key);
  final File item;

  @override
  Widget build(BuildContext context) {
    return ExtendedImageSlidePage(
      child: GestureDetector(
        child: Hero(
            tag: item.uri,
            child: ExtendedImage.file(
              item,
              fit: BoxFit.contain,
              enableLoadState: false,
              mode: ExtendedImageMode.gesture,
              initGestureConfigHandler: (state) {
                return GestureConfig(
                  minScale: 0.9,
                  animationMinScale: 0.7,
                  maxScale: 3.0,
                  animationMaxScale: 3.5,
                  speed: 1.0,
                  inertialSpeed: 100.0,
                  initialScale: 1.0,
                  inPageView: false,
                  initialAlignment: InitialAlignment.center,
                );
              },
            )),
        onTap: () {
          Navigator.pop(context);
        },
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
