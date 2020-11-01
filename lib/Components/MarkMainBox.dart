import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/data/SampleDate.dart';
import 'package:suyu_simple/model/DailyRecorderModel.dart';

import 'MarkDetailLi.dart';
import 'TextWithUnderLine.dart';
import 'TotalMark.dart';

class MarkMainBox extends StatefulWidget {
  MarkMainBox({Key key}) : super(key: key);

  @override
  _MarkMainBoxState createState() => _MarkMainBoxState();
}

class _MarkMainBoxState extends State<MarkMainBox> {
  DailyRecorderModel dailyRecorderModel;
  initState() {
    super.initState();
    dailyRecorderModel = SampleDate.todayRecorder;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextWithUnderLine(),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Column(
              children: dailyRecorderModel.list
                  .map((item) => new MarkDetailLi(item))
                  .toList(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            TotalMark(dailyRecorderModel.list),
          ],
        ),
      ),
      height: 393.h,
      width: 343.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.colorBlack,
          width: 3.0, //边框粗细
        ), //容器内的方框弧度
        borderRadius: BorderRadius.all(const Radius.circular(10.0)),
      ),
    );
  }
}
