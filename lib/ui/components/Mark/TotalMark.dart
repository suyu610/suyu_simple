import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/model/MarkItemModel.dart';
import 'package:suyu_simple/provider/DailyMarkProvider.dart';
import 'package:suyu_simple/provider/FontFamilyProvider.dart';

class TotalMark extends StatefulWidget {
  final List<MarkItemModel> markItemModellist;
  TotalMark(this.markItemModellist, {Key key}) : super(key: key);

  @override
  _TotalMarkState createState() => _TotalMarkState(markItemModellist);
}

class _TotalMarkState extends State<TotalMark> {
  final List<MarkItemModel> markItemModellist;
  _TotalMarkState(this.markItemModellist);
  int totalScore = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("总分:",
            style: TextStyle(
              fontFamily: Provider.of<FontFamilyProvider>(context).fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(16),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //分数
            Container(
              child: Text(
                  Provider.of<DailyMarkProvider>(context)
                      .totalValue()
                      .toString(),
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationColor: ThemeColors.colorTheme,
                    decorationThickness: 3,
                    fontWeight: FontWeight.bold,
                    fontFamily:
                        Provider.of<FontFamilyProvider>(context).fontFamily,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
            ),
            Text(
                "/ " +
                    Provider.of<DailyMarkProvider>(context)
                        .getLevel()
                        .toString() +
                    " /",
                style: TextStyle(
                    fontFamily:
                        Provider.of<FontFamilyProvider>(context).fontFamily,
                    fontSize: ScreenUtil().setSp(14),
                    // fontWeight: FontWeight.bold,
                    color: ThemeColors.colorBlack)),
          ],
        )
      ],
    );
  }
}
