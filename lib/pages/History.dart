import 'package:flutter/material.dart';
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
        body: SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: ChartTitle(text: '十月宇崽表现'),
          legend: Legend(),
          primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),
              labelPlacement: LabelPlacement.onTicks),
          primaryYAxis: NumericAxis(
              minimum: 25,
              maximum: 50,
              axisLine: AxisLine(width: 0),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelFormat: '{value}分',
              majorTickLines: MajorTickLines(size: 0)),
          series: _getDefaultSplineSeries(),
          tooltipBehavior: TooltipBehavior(enable: true),
        ));
  }
}

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
