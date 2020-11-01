import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/Components/MyMarkButton.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/provider/DailyMarkProvider.dart';

class MarkDetailLi extends StatefulWidget {
  final int index;
  MarkDetailLi(this.index, {Key key}) : super(key: key);
  @override
  _MarkDetailLiState createState() => _MarkDetailLiState(index);
}

class _MarkDetailLiState extends State<MarkDetailLi> {
  _MarkDetailLiState(this.index);
  final int index;

  void handleAddBtnClick() {
    Provider.of<DailyMarkProvider>(context, listen: false).increment(index);
  }

  void handleMinusBtnClick() {
    Provider.of<DailyMarkProvider>(context, listen: false).decrement(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(30),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5), //外边距，
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(Provider.of<DailyMarkProvider>(context).getTitle(index),
              style: TextStyle(
                  fontFamily: 'myFont', fontSize: ScreenUtil().setSp(16))),
          MyMarkButton(
            isAdd: false,
            isYellow: false,
            width: 43.w,
            tapAction: handleMinusBtnClick,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    // 设置单侧边框的样式
                    color: ThemeColors.colorBlack,
                    width: 2,
                    style: BorderStyle.solid),
              ),
            ),
            width: ScreenUtil().setWidth(30),
            child: Text(
              Provider.of<DailyMarkProvider>(context)
                  .getCurrentValue(index)
                  .toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'myFont',
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.bold),
            ),
          ),
          MyMarkButton(
            width: 43.w,
            isAdd: true,
            isYellow: true,
            tapAction: handleAddBtnClick,
          ),
        ],
      ),
    );
  }
}
