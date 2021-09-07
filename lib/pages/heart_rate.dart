import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';
import 'package:it_innova_flutter/widgets/heart_rate_chart.dart';
import 'package:it_innova_flutter/widgets/heart_rate_indicator.dart';

class HeartRate extends StatefulWidget {
  const HeartRate({Key? key}) : super(key: key);

  @override
  _HeartRateState createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  final List<HeartRateHistory> _heartRateHistoryList = [
    HeartRateHistory(bpm: 80, date: '23/04/2021'),
    HeartRateHistory(bpm: 50, date: '01/05/2021'),
    HeartRateHistory(bpm: 75, date: '22/05/2021'),
    HeartRateHistory(bpm: 125, date: '23/05/2021'),
    HeartRateHistory(bpm: 145, date: '24/05/2021'),
    HeartRateHistory(bpm: 150, date: '25/05/2021'),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ritmo cardiaco',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            SizedBox(height: width * 0.05),
            HeartRateIndicator(bpm: 89),
            SizedBox(height: width * 0.1),
            HeartRateChart(
              data: _heartRateHistoryList,
            ),
          ],
        ),
      ),
    );
  }
}
