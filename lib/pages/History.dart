import 'package:flutter/material.dart';
import 'package:suyu_simple/common/ThemeColor.dart';
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
          title: const Text('历史记录'),
        ),
        body: _getHorizantalGradientAreaChart());
  }
  // body: SfCartesianChart(
  //   plotAreaBorderWidth: 0,
  //   title: ChartTitle(text: '十月宇崽表现'),
  //   legend: Legend(),
  //   primaryXAxis: CategoryAxis(
  //       majorGridLines: MajorGridLines(width: 0),
  //       labelPlacement: LabelPlacement.onTicks),
  //   primaryYAxis: NumericAxis(
  //       minimum: 25,
  //       maximum: 50,
  //       axisLine: AxisLine(width: 0),
  //       edgeLabelPlacement: EdgeLabelPlacement.shift,
  //       labelFormat: '{value}分',
  //       majorTickLines: MajorTickLines(size: 0)),
  //   series: _getDefaultSplineSeries(),
  //   tooltipBehavior: TooltipBehavior(enable: true),
  // ));
}

/////////////////////////
///  /// Return the circular chart with horizontal gradient.
SfCartesianChart _getHorizantalGradientAreaChart() {
  return SfCartesianChart(
    plotAreaBorderWidth: 1,
    title: ChartTitle(text: '十月表现'),
    primaryXAxis: CategoryAxis(
        labelPlacement: LabelPlacement.betweenTicks,
        // interval: model.isWeb ? 1 : null,
        labelRotation: -45,
        majorGridLines: MajorGridLines(width: 0)),
    tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
    primaryYAxis: NumericAxis(
        interval: 2,
        minimum: 80,
        maximum: 100,
        labelFormat: '{value}分',
        axisLine: AxisLine(width: 0),
        majorTickLines: MajorTickLines(size: 0)),
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
  final List<Color> color = <Color>[];
  color.add(Colors.blue[200]);
  color.add(Colors.orange[200]);

  final List<double> stops = <double>[];
  stops.add(0.2);
  stops.add(0.7);

  return <ChartSeries<_ChartData, String>>[
    SplineAreaSeries<_ChartData, String>(
      /// To set the gradient colors for border here.
      borderGradient: const LinearGradient(colors: <Color>[
        Color.fromRGBO(212, 126, 166, 1),
        Color.fromRGBO(222, 187, 104, 1)
      ], stops: <double>[
        0.2,
        0.9
      ]),

      /// To set the gradient colors for series.
      gradient: const LinearGradient(colors: <Color>[
        Color.fromRGBO(224, 139, 207, 0.9),
        Color.fromRGBO(255, 232, 149, 0.9)
      ], stops: <double>[
        0.2,
        0.9
      ]),
      borderWidth: 2,
      markerSettings: MarkerSettings(
          isVisible: false,
          height: 8,
          width: 8,
          color: ThemeColors.colorWhite,
          borderColor: ThemeColors.colorWhite,
          borderWidth: 1),
      borderDrawMode: BorderDrawMode.top,
      dataSource: chartData,
      xValueMapper: (_ChartData sales, _) => sales.x,
      yValueMapper: (_ChartData sales, _) => sales.y,
      name: '评分',
    )
  ];
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String x;
  final double y;
}

// ////////////////////

/// Returns the list of chart series which need to render on the spline chart.
List<SplineSeries<ChartSampleData, String>> _getDefaultSplineSeries() {
  final List<ChartSampleData> chartData = <ChartSampleData>[
    ChartSampleData(
        x: "1号", y: 43, secondSeriesYValue: 37, thirdSeriesYValue: 31),
    ChartSampleData(
        x: '2号', y: 45, secondSeriesYValue: 37, thirdSeriesYValue: 35),
    ChartSampleData(
        x: '3号', y: 50, secondSeriesYValue: 39, thirdSeriesYValue: 38),
    ChartSampleData(
        x: '4号', y: 45, secondSeriesYValue: 43, thirdSeriesYValue: 32),
    ChartSampleData(
        x: '5号', y: 43, secondSeriesYValue: 40, thirdSeriesYValue: 37),
    ChartSampleData(
        x: '6号', y: 48, secondSeriesYValue: 40, thirdSeriesYValue: 31),
    ChartSampleData(
        x: '7号', y: 40, secondSeriesYValue: 34, thirdSeriesYValue: 36),
    ChartSampleData(
        x: '8号', y: 40, secondSeriesYValue: 43, thirdSeriesYValue: 39),
    ChartSampleData(
        x: '9号', y: 66, secondSeriesYValue: 44, thirdSeriesYValue: 35),
    ChartSampleData(
        x: '10号', y: 57, secondSeriesYValue: 42, thirdSeriesYValue: 35),
    ChartSampleData(
        x: '11号', y: 50, secondSeriesYValue: 43, thirdSeriesYValue: 30),
    ChartSampleData(
        x: '12号', y: 45, secondSeriesYValue: 37, thirdSeriesYValue: 35)
  ];
  return <SplineSeries<ChartSampleData, String>>[
    SplineSeries<ChartSampleData, String>(
      dataSource: chartData,
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
      markerSettings: MarkerSettings(isVisible: true),
      name: '准时',
    ),
    SplineSeries<ChartSampleData, String>(
      dataSource: chartData,
      name: '锻炼',
      markerSettings: MarkerSettings(isVisible: true),
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
    )
  ];
}

class ChartSampleData {
  ChartSampleData(
      {this.x, this.y, this.secondSeriesYValue, this.thirdSeriesYValue});
  final String x;
  final int y;
  final int secondSeriesYValue;
  final int thirdSeriesYValue;
}
