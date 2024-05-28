import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BMIChart extends StatelessWidget {
  final List<String> xData;
  final List<double> yData;

  const BMIChart({Key? key, required this.xData, required this.yData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: xData.length * 100.0,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(
                  title: AxisTitle(text: 'Date'),
                  labelRotation: 45,
                  labelIntersectAction: AxisLabelIntersectAction.rotate45,
                  isInversed: true,
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  arrangeByIndex: true,
                ),
                primaryYAxis: const NumericAxis(
                  title: AxisTitle(text: 'BMI'), // Naslov za Y osu
                ),
                series: <CartesianSeries<dynamic, dynamic>>[
                  LineSeries<dynamic, dynamic>(
                    dataSource: _generateDataPoints(xData, yData),
                    xValueMapper: (dynamic sales, _) => (sales as _DataPoint).x,
                    yValueMapper: (dynamic sales, _) => (sales as _DataPoint).y,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<_DataPoint> _generateDataPoints(List<String> xData, List<double> yData) {
    assert(xData.length == yData.length);

    List<_DataPoint> dataPoints = [];
    for (int i = 0; i < xData.length; i++) {
      dataPoints.add(_DataPoint(xData[i], yData[i]));
    }
    return dataPoints;
  }
}

class _DataPoint {
  final String x;
  final double y;

  _DataPoint(this.x, this.y);
}
