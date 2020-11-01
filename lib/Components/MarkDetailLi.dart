import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/model/MarkItemModel.dart';
import 'MyButton.dart';

class MarkDetailLi extends StatefulWidget {
  final MarkItemModel markItemModel;
  MarkDetailLi(this.markItemModel, {Key key}) : super(key: key);

  @override
  _MarkDetailLiState createState() => _MarkDetailLiState(markItemModel);
}

class _MarkDetailLiState extends State<MarkDetailLi> {
  _MarkDetailLiState(this.markItemModel);
  final MarkItemModel markItemModel;
  TextEditingController _editingController = new TextEditingController();

  void handleAddBtnClick() {
    setState(() {
      markItemModel.currentScore++;
    });
  }

  void handleMinusBtnClick() {
    setState(() {
      markItemModel.currentScore--;
    });
  }

  @override
  Widget build(BuildContext context) {
    _editingController.text = markItemModel.currentScore.toString();
    _editingController.addListener(() {
      ///获取输入的内容
      markItemModel.currentScore = int.parse(_editingController.text);
    });
    return Container(
      height: ScreenUtil().setHeight(30),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5), //外边距，
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(markItemModel.title,
              style: TextStyle(fontSize: ScreenUtil().setSp(16))),
          myMarkButton(
            isAdd: false,
            isYellow: false,
            height: 18.h,
            width: 53.w,
            tapAction: handleMinusBtnClick,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    // 设置单侧边框的样式
                    color: ThemeColors.colorBlack,
                    width: 3,
                    style: BorderStyle.solid),
              ),
            ),
            width: ScreenUtil().setWidth(35),
            child: TextField(
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              maxLength: 2,
              minLines: 1,
              maxLines: 1,
              controller: _editingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: '', // 去除输入框底部的字符计数
                  fillColor: Colors.transparent,
                  filled: false,
                  labelText: ''),
            ),
          ),
          // Text("40", style: TextStyle(fontSize: ScreenUtil().setSp(16))),
          myMarkButton(
            height: 18.h,
            width: 53.w,
            tapAction: handleAddBtnClick,
          ),
        ],
      ),
    );
  }
}
