import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';

class HeartRateListView extends StatelessWidget {
  const HeartRateListView({
    Key? key,
    required List<HeartRateHistory> heartRateHistoryList,
  })  : _heartRateHistoryList = heartRateHistoryList,
        super(key: key);

  final List<HeartRateHistory> _heartRateHistoryList;

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
