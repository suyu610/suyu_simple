import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/ui/Components/MyButton.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
import 'package:suyu_simple/common/ThemeFonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HistoryPage({Key key}) : super(key: key);

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.colorTheme,
          elevation: 0,
          title: const Text(
            '历史记录',
            textAlign: TextAlign.center,
          ),
        ),
        body: _getHorizantalGradientAreaChart());
  }
}

///  /// Return the circular chart with horizontal gradient.
Widget _getHorizantalGradientAreaChart() {
  return Container(
    decoration: ThemeFonts.lineBoxDecoration,
    padding: EdgeInsets.only(top: 40.h, bottom: 100.h, left: 10.w, right: 10.w),
    height: 675.h,
    width: 375.w,
    child: Column(
      children: <Widget>[
        Text(
          "十月记录",
          style: ThemeFonts.titleFont,
        ),
        Padding(
          padding: EdgeInsets.all(30.h),
        ),
        SfCartesianChart(
          backgroundColor: ThemeColors.colorWhite,
          borderWidth: 2,
          borderColor: ThemeColors.colorBlack,
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            labelRotation: -45,
            axisLine: AxisLine(width: 1),
            majorGridLines: MajorGridLines(width: 0),
          ),
          tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: true),
          primaryYAxis: NumericAxis(
            interval: 2,
            minimum: 85,
            maximum: 100,
            labelFormat: '{value}分',
            axisLine: AxisLine(width: 1),
          ),
          series: _getGradientAreaSeries(),
          onMarkerRender: (MarkerRenderArgs args) {
            if (args.pointIndex == 0) {
              args.color = const Color.fromRGBO(207, 124, 168, 1);
            } else if (args.pointIndex == 1) {
              args.color = const Color.fromRGBO(210, 133, 167, 1);
            } else if (args.pointIndex == 2) {
              args.color = const Color.fromRGBO(219, 128, 161, 1);
            } else if (args.pointIndex == 3) {
              args.color = const Color.fromRGBO(213, 143, 151, 1);
            } else if (args.pointIndex == 4) {
              args.color = const Color.fromRGBO(226, 157, 126, 1);
            } else if (args.pointIndex == 5) {
              args.color = const Color.fromRGBO(220, 169, 122, 1);
            } else if (args.pointIndex == 6) {
              args.color = const Color.fromRGBO(221, 176, 108, 1);
            } else if (args.pointIndex == 7) {
              args.color = const Color.fromRGBO(222, 187, 97, 1);
            }
          },
        ),
        Padding(
          padding: EdgeInsets.all(30.h),
        ),
        MyButton("亲他一下",
            width: 117.w,
            height: 24.h,
            isYellow: false,
            fontSize: 15.sp,
            tapAction: () => EasyLoading.showToast('收到!',
                duration: Duration(milliseconds: 500),
                toastPosition: EasyLoadingToastPosition.bottom)),
      ],
    ),
  );
}

/// Returns the list of spline area series with horizontal gradient.
List<ChartSeries<_ChartData, String>> _getGradientAreaSeries() {
  final List<_ChartData> chartData = <_ChartData>[
    _ChartData(x: "10月1日", y: 94),
    _ChartData(x: "10月2日", y: 96),
    _ChartData(x: '10月3日', y: 98),
    _ChartData(x: '10月4日', y: 90),
    _ChartData(x: '10月5日', y: 93),
    _ChartData(x: '10月6日', y: 90),
    _ChartData(x: '10月7日', y: 88),
    _ChartData(x: '10月8日', y: 98),
    _ChartData(x: '10月9日', y: 94),
    _ChartData(x: '10月10日', y: 92),
    _ChartData(x: '10月11日', y: 93),
    _ChartData(x: '10月12日', y: 90),
    _ChartData(x: '10月13日', y: 96),
    _ChartData(x: '10月14日', y: 90)
  ];

  final List<double> stops = <double>[];
  stops.add(0.4);
  stops.add(0.5);
  return <ChartSeries<_ChartData, String>>[
    SplineAreaSeries<_ChartData, String>(
      /// To set the gradient colors for border here.
      borderGradient: const LinearGradient(colors: <Color>[
        Color.fromRGBO(1, 1, 1, 1),
        Color.fromRGBO(1, 1, 1, 1),
      ], stops: <double>[
        0.2,
        0.9
      ]),

      /// To set the gradient colors for series.
      gradient: const LinearGradient(colors: <Color>[
        Color.fromRGBO(254, 212, 91, 1),

        Color.fromRGBO(254, 212, 91, 0.6),
        // Color.fromRGBO(30, 170, 241, 1),
        // Color.fromRGBO(114, 198, 241, 0.6),
      ], stops: <double>[
        0.6,
        0.9,
        // 1,
      ]),
      borderWidth: 2,
      borderColor: Color.fromRGBO(0, 0, 0, 1),
      markerSettings: MarkerSettings(
          isVisible: false,
          height: 12,
          width: 12,
          color: Color.fromRGBO(255, 255, 255, 1),
          borderColor: Color.fromRGBO(0, 0, 0, 0.4),
          borderWidth: 2),
      borderDrawMode: BorderDrawMode.top,
      dataSource: chartData,
      xValueMapper: (_ChartData sales, _) => sales.x,
      yValueMapper: (_ChartData sales, _) => sales.y,
      name: '今日评分',
    )
  ];
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String x;
  final double y;
}
