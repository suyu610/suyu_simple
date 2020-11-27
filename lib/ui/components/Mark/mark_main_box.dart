import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/model/daily_recorder.dart';
import 'package:suyu_simple/provider/daily_mark_provider.dart';
import 'package:suyu_simple/provider/font_family_provider.dart';
import 'package:suyu_simple/provider/user_provider.dart';
import 'package:suyu_simple/sampleData/sample_date.dart';
import 'package:suyu_simple/ui/components/Mark/total_mark.dart';

import 'mark_detail_li.dart';

class MarkMainBox extends StatefulWidget {
  MarkMainBox({Key key}) : super(key: key);

  @override
  _MarkMainBoxState createState() => _MarkMainBoxState();
}

class _MarkMainBoxState extends State<MarkMainBox> {
  DailyRecorder dailyRecorder;
  initState() {
    super.initState();
    dailyRecorder = SampleDate.todayRecorder;
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
                Stack(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "${Provider.of<UserProvider>(context).getUser().nickname}今天表现怎么样",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontFamily: Provider.of<FontFamilyProvider>(context)
                              .fontFamily,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                ),
                Container(
                    height: 285.h,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(accentColor: ThemeColors.colorWhite),
                      child: Center(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: Provider.of<DailyMarkProvider>(context)
                                .getLength(), //.length,
                            itemBuilder: (BuildContext context, int index) {
                              return MarkDetailLi(index);
                            }),
                      ),
                    )),
                // Column(children: <Widget>[
                // ]),
              ],
            ),
            TotalMark(dailyRecorder.list),
          ],
        ),
      ),
      height: 400.h,
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