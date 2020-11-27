import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/provider/daily_mark_provider.dart';
import 'package:suyu_simple/provider/font_family_provider.dart';
import 'package:suyu_simple/provider/theme_provider.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';

import '../my_mark_button.dart';

class MarkDetailLi extends StatefulWidget {
  final int index;
  MarkDetailLi(this.index, {Key key}) : super(key: key);
  @override
  _MarkDetailLiState createState() => _MarkDetailLiState(index);
}

class _MarkDetailLiState extends State<MarkDetailLi> {
  _MarkDetailLiState(this.index);
  final int index;
  int selectedFoodVariants = 0;
  int selectedPortionCounts = 0;
  int selectedPortionSize = 0;

  void handleAddBtnClick() {
    Provider.of<DailyMarkProvider>(context, listen: false).increment(index);
  }

  @override
  void initState() {
    super.initState();
  }

  void handleMinusBtnClick() {
    // EasyLoading.showError('姐姐快停手!');
    EasyLoading.showToast('求求你别减了!',
        duration: Duration(milliseconds: 500),
        toastPosition: EasyLoadingToastPosition.top);

    Provider.of<DailyMarkProvider>(context, listen: false).decrement(index);
  }

  void _showScaffold() {
    final snackBar = SnackBar(content: Text('可以按住拖动'));
    Provider.of<ThemeProvider>(context, listen: false)
        .scaffoldKey
        .currentState
        .showSnackBar(snackBar);
  }

  DirectSelectItem<int> getDropDownMenuItem(int value) {
    return DirectSelectItem<int>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 20.w,
                child: Text(
                  value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily:
                          Provider.of<FontFamilyProvider>(context).fontFamily,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700),
                ),
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
                      fontFamily:
                          Provider.of<FontFamilyProvider>(context).fontFamily,
                      color: ThemeColors.colorBlack,
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w100),
                ),
              ),
            ],
          );
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      // color: ThemeColors.colorTheme,
      border: BorderDirectional(
        bottom: BorderSide(width: 2, color: ThemeColors.colorBlack),
        top: BorderSide(width: 2, color: ThemeColors.colorBlack),
      ),
    );
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
                      fontFamily:
                          Provider.of<FontFamilyProvider>(context).fontFamily,
                      fontSize: ScreenUtil().setSp(16))),
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
            child: DirectSelectList<int>(
              onUserTappedListener: () {
                _showScaffold();
              },
              values: List.generate(
                  Provider.of<DailyMarkProvider>(context, listen: false)
                          .getMaxValue(index) +
                      1,
                  (i) => i),
              defaultItemIndex:
                  Provider.of<DailyMarkProvider>(context, listen: false)
                      .getCurrentValue(index),
              itemBuilder: (int value) => getDropDownMenuItem(value),
              focusedItemDecoration: _getDslDecoration(),
              onItemSelectedListener: (item, _index, context) {
                setState(() {
                  Provider.of<DailyMarkProvider>(context, listen: false)
                      .setValue(index, _index);
                });
              },
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
