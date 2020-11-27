import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:suyu_simple/constant/theme_color.dart';
import 'package:suyu_simple/constant/theme_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HistoryPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HistoryPage({Key key}) : super(key: key);

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  double _value = 30;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ThemeFonts.lineBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getHorizantalGradientAreaChart(),
          this.dashboard(),
        ],
      ),
    );
  }

  dashboard() {
    return Container(
      child: SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: 3500,
          axes: <RadialAxis>[
            RadialAxis(
              // 地盘
              showAxisLine: true,
              showLabels: true,
              showTicks: false,
              minimum: 0,
              maximum: 100,
              startAngle: 180,
              endAngle: 45,
              useRangeColorForAxis: false,
              interval: 20,
              // 表盘
              axisLineStyle: AxisLineStyle(
                thickness: 0.23,
                thicknessUnit: GaugeSizeUnit.factor,
                color: Colors.grey.shade300,
              ),

              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 100,
                    color: ThemeColors.colorTheme,
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.23,
                    endWidth: 0.23),
              ],

              pointers: <GaugePointer>[
                RangePointer(
                    sizeUnit: GaugeSizeUnit.factor,
                    value: _value,
                    width: 0.23,
                    enableAnimation: true,
                    animationDuration: 1200,
                    animationType: AnimationType.ease,
                    color: Color(0xffff7471),
                    enableDragging: true,
                    onValueChanging: onValueChanging,
                    onValueChanged: onvalueChanged),
                NeedlePointer(
                    onValueChanging: onValueChanging,
                    enableAnimation: true,
                    value: _value,
                    needleStartWidth: 1,
                    needleEndWidth: 5,
                    // 中心的圈
                    knobStyle: KnobStyle(
                        color: Colors.white,
                        borderColor: Color(0xFFDADADA),
                        knobRadius: 0.06,
                        borderWidth: 0.04),
                    tailStyle: TailStyle(
                        color: Color(0xFFDADADA), width: 5, length: 0.15)),
              ],

              axisLabelStyle:
                  GaugeTextStyle(fontWeight: FontWeight.w300, fontSize: 12),
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                      child: Text("他现在的心情",
                          // (NumUtil.getNumByValueDouble(_value, 1))
                          //     .toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold)),
                    ),
                    angle: 90,
                    positionFactor: 0.5)
              ],
            )
          ]),
    );
  }

  void onValueChanging(ValueChangingArgs args) {
    _value = args.value;
    setState(() {});
  }

  void onvalueChanged(double value) {}
}

///  /// Return the circular chart with horizontal gradient.
Widget _getHorizantalGradientAreaChart() {
  return Container(
    padding: EdgeInsets.only(top: 0.h, bottom: 10.h, left: 20.w, right: 20.w),
    child: Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => {},
          child: Container(
            width: 200.w,
            margin: EdgeInsets.only(top: 20.h),
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: Color.fromRGBO(254, 212, 91, 1),
              boxShadow: [
                new BoxShadow(
                    color: Color.fromRGBO(173, 179, 191, 0.3),
                    blurRadius: 1.0,
                    offset: new Offset(0, 0))
              ],
              border: Border.merge(
                new Border(left: BorderSide(color: Colors.black, width: 5)),
                new Border(right: BorderSide(color: Colors.black, width: 5)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.black,
                  size: 18.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                ),
                Text(
                  "十一月记录",
                  style: TextStyle(
                      letterSpacing: 5.w,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(15),
                      fontFamily: 'myFont'),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5.h),
        ),
        SfCartesianChart(
          backgroundColor: Colors.white,
          borderWidth: 0,
          borderColor: Colors.transparent,
          plotAreaBorderWidth: 1,
          primaryXAxis: CategoryAxis(
            labelPlacement: LabelPlacement.onTicks,
            labelRotation: -45,
            axisLine: AxisLine(width: 1),
            majorGridLines: MajorGridLines(width: 1),
          ),
          tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: true),
          primaryYAxis: NumericAxis(
            majorTickLines:
                MajorTickLines(size: 6, width: 2, color: Colors.red),
            isVisible: true,
            // desiredIntervals: 1,
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
        // Color.fromRGBO(254, 212, 91, 0.6),
        // Color.fromRGBO(30, 170, 241, 1),
        // Color.fromRGBO(114, 198, 241, 0.6),
      ], stops: <double>[
        0.6,
        // 1,
      ]),
      borderWidth: 2,
      borderColor: Color.fromRGBO(0, 0, 0, 1),
      // markerSettings: MarkerSettings(
      //     isVisible: false,
      //     height: 12,
      //     width: 12,
      //     color: Color.fromRGBO(255, 255, 255, 1),
      //     borderColor: Color.fromRGBO(0, 0, 0, 0.4),
      //     borderWidth: 2),
      borderDrawMode: BorderDrawMode.all,
      dataSource: chartData,
      xValueMapper: (_ChartData sales, _) => sales.x,
      yValueMapper: (_ChartData sales, _) => sales.y,
      // name: '今日评分',
    )
  ];
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String x;
  final double y;
}
