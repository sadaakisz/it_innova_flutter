import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/alert_history.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';
import 'package:it_innova_flutter/widgets/alert_list_view.dart';
import 'package:it_innova_flutter/widgets/heart_rate_list_view.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool _showHeartRate = true;

  final List<HeartRateHistory> _heartRateHistoryList = [
    HeartRateHistory(bpm: 80, date: '23/04/2021'),
    HeartRateHistory(bpm: 100, date: '01/05/2021'),
    HeartRateHistory(bpm: 95, date: '22/05/2021'),
  ];

  final List<AlertHistory> _alertHistoryList = [
    AlertHistory(name: 'Arritmia', date: '23/04/2021'),
    AlertHistory(name: 'Hipertensión', date: '01/05/2021'),
    AlertHistory(name: 'Arritmia', date: '22/05/2021'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _showHeartRate ? 'Historial Ritmo Cardiaco' : 'Historial de Alertas',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _showHeartRate
          ? HeartRateListView(heartRateHistoryList: _heartRateHistoryList)
          : AlertListView(alertHistoryList: _alertHistoryList),
      floatingActionButton: FloatingActionButton(
        child: _showHeartRate
            ? Icon(Icons.priority_high)
            : Icon(Icons.favorite_border),
        onPressed: () {
          setState(() {
            _showHeartRate = !_showHeartRate;
          });
          ;
        },
      ),
    );
  }
}
