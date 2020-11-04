import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';

class ChatBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
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
              Icon(
                Icons.delete_sweep,
                color: ThemeColors.colorBlack,
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
