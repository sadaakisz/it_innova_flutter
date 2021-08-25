import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';

class History extends StatelessWidget {
  History({Key? key}) : super(key: key);
  final List<HeartRateHistory> _heartRateHistoryList = [
    HeartRateHistory(bpm: 80, date: '23/04/2021'),
    HeartRateHistory(bpm: 100, date: '01/05/2021'),
    HeartRateHistory(bpm: 95, date: '22/05/2021'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _heartRateHistoryList.length,
      itemBuilder: (BuildContext context, int index) {
        var heartRateItem = _heartRateHistoryList[index];
        return ListTile(
          title: Text(heartRateItem.bpm.toString() + ' BPM'),
          subtitle: Text(heartRateItem.date),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 5);
      },
    );
  }
}
