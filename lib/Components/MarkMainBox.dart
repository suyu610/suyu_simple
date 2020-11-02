import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/components/MarkDetailLi.dart';
import 'package:suyu_simple/provider/DailyMarkProvider.dart';
import 'package:suyu_simple/sampleData/SampleDate.dart';
import 'package:suyu_simple/model/DailyRecorderModel.dart';

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

  ///下拉刷新方法,为list重新赋值
  ///   
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      // IMP: 刷新获取的数据
      print('refresh');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextWithUnderLine("宇崽"),
                    Text(
                      "今天表现怎么样?",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        fontFamily: 'myFont',
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Container(
                    height: 275.h,
                    child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      backgroundColor: ThemeColors.colorTheme,
                      color: ThemeColors.colorBlack,
                      child: Theme(                        
                        data: Theme.of(context)
                            .copyWith(accentColor: ThemeColors.colorWhite),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: Provider.of<DailyMarkProvider>(context)
                                .getLength(), //.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MarkDetailLi(index);
                            }),
                      ),
                    )
                    /*
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        MarkDetailLi(0),
                        MarkDetailLi(1),
                        MarkDetailLi(2),
                        MarkDetailLi(3),
                        MarkDetailLi(4),
                        MarkDetailLi(5),
                        MarkDetailLi(6),
                        MarkDetailLi(6),
                      ],
                    ),
                  ),
                  */
                    ),
                // Column(children: <Widget>[
                // ]),
              ],
            ),
            TotalMark(dailyRecorderModel.list),
          ],
        ),
      ),
      height: 393.h,
      width: 343.w,
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.5),
        border: Border.all(
          color: ThemeColors.colorBlack,
          width: 3, //边框粗细
        ), //容器内的方框弧度
        borderRadius: BorderRadius.all(const Radius.circular(10.0)),
      ),
    );
  }
}
