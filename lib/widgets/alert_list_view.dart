import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/alert_history.dart';

class AlertListView extends StatelessWidget {
  const AlertListView({
    Key? key,
    required List<AlertHistory> alertHistoryList,
  })  : _alertHistoryList = alertHistoryList,
        super(key: key);

  final List<AlertHistory> _alertHistoryList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _alertHistoryList.length,
      itemBuilder: (BuildContext context, int index) {
        var alertItem = _alertHistoryList[index];
        var name = alertItem.name;
        var bpm = alertItem.heartRate;
        return ListTile(
          title: Text("$name - $bpm BPM"),
          subtitle: Text(alertItem.date),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(height: 5);
      },
    );
  }
}
