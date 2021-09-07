import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';

class HeartRateChart extends StatelessWidget {
  final List<HeartRateHistory> data;
  const HeartRateChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<charts.Series<HeartRateHistory, String>> series = [
      charts.Series(
        id: "HeartRateHistory",
        data: data,
        domainFn: (HeartRateHistory series, _) => series.date.substring(0, 5),
        measureFn: (HeartRateHistory series, _) => series.bpm,
        colorFn: (_, __) => charts.MaterialPalette.pink.shadeDefault,
      )
    ];
    return Container(
        height: height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ritmo Cardiaco',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * 0.03),
            Expanded(
              child: charts.BarChart(
                series,
                animate: true,

                /// Assign a custom style for the domain axis.
                ///
                /// This is an OrdinalAxisSpec to match up with BarChart's default
                /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
                /// other charts).
                domainAxis: new charts.OrdinalAxisSpec(
                    renderSpec: new charts.SmallTickRendererSpec(
                        // Change the line colors to match text color.
                        lineStyle: new charts.LineStyleSpec(
                            color: charts.MaterialPalette.black))),

                /// Assign a custom style for the measure axis.
                primaryMeasureAxis: new charts.NumericAxisSpec(
                    renderSpec: new charts.GridlineRendererSpec(
                        // Change the line colors to match text color.
                        lineStyle: new charts.LineStyleSpec(
                            color: charts.MaterialPalette.black))),
              ),
            ),
          ],
        ));
  }
}
