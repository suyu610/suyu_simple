import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/provider/ChatProvider.dart';

class ChatBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    void handledeleteAllMsg() {
      Provider.of<ChatProvider>(context, listen: false).deleteAllMsg();
    }

    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10.w,
              ),
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/girl.png"),
                maxRadius: 20,
              ),
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "当前在线人数",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Text(
                      "17人",
                      style: TextStyle(color: Colors.green, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Icon(
                  Ionicons.trash_outline,
                  color: ThemeColors.colorBlack,
                ),
                onTap: handledeleteAllMsg,
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                child: Icon(
                  Ionicons.planet_outline,
                  color: ThemeColors.colorBlack,
                ),
                onTap: handledeleteAllMsg,
              ),
              SizedBox(
                width: 10.w,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
