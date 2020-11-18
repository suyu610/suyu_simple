import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAboutDialog extends StatefulWidget {
  MyAboutDialog({Key key}) : super(key: key);

  @override
  _MyAboutDialogState createState() => _MyAboutDialogState();
}

class _MyAboutDialogState extends State<MyAboutDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0)), //this right here
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 300.h,
          width: 300.w,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "素语评分",
                      style: TextStyle(fontSize: 20.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "v0.2",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                // TODO
                // 来自后端请求，并缓存，以及验证是否为最新
                Text(
                  "一些介绍一些介绍一些介绍一些介绍一些介绍一些介绍一些介绍一些介绍一些介绍一些介绍一些介绍一些介绍",
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black,
                    ),
                    child: Text(
                      "查看详细介绍",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
