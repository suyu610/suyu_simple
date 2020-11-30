import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/provider/theme_provider.dart';

// ignore: must_be_immutable
class MenuItem extends StatelessWidget {
  MenuItem({this.title, this.icon, this.tapAction, Key key}) : super(key: key);
  String title;
  IconData icon;
  Function tapAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        tapAction(),
        Provider.of<ThemeProvider>(context, listen: false)
            .innerDrawerKey
            .currentState
            .toggle(direction: InnerDrawerDirection.start),
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 16.sp,
              ),
              SizedBox(width: 30.w),
              SizedBox(
                width: 60.w,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
