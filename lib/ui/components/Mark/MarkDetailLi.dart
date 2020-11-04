import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/ui/Components/MyMarkButton.dart';
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
    // EasyLoading.showError('姐姐快停手!');
    EasyLoading.showToast('求求你别减了!',
        duration: Duration(milliseconds: 500),
        toastPosition: EasyLoadingToastPosition.top);

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
          Container(
            width: 100.w,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                  Provider.of<DailyMarkProvider>(context).getTitle(index),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'myFont', fontSize: ScreenUtil().setSp(16))),
            ),
          ),
          MyMarkButton(
            isAdd: false,
            isYellow: false,
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
            width: ScreenUtil().setWidth(60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Provider.of<DailyMarkProvider>(context)
                      .getCurrentValue(index)
                      .toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'myFont',
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
                Opacity(opacity: 0.5, child: Text(" / ")),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    Provider.of<DailyMarkProvider>(context)
                        .getMaxValue(index)
                        .toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'myFont',
                        color: ThemeColors.colorBlack,
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ],
            ),
          ),
          MyMarkButton(
            isAdd: true,
            isYellow: true,
            tapAction: handleAddBtnClick,
          ),
        ],
      ),
    );
  }
}
