import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/alert_history.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';
import 'package:it_innova_flutter/services/heart_rate_service.dart';
import 'package:it_innova_flutter/widgets/alert_list_view.dart';
import 'package:it_innova_flutter/widgets/heart_rate_list_view.dart';

class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool _showHeartRate = true;

  HeartRateService heartRateService = new HeartRateService();
  bool historyLoaded = false;

  List<HeartRateHistory> _heartRateHistoryList = [];

  List<AlertHistory> _alertHistoryList = [
    AlertHistory(name: 'Arritmia', date: '23/04/2021'),
    AlertHistory(name: 'Hipertensión', date: '01/05/2021'),
    AlertHistory(name: 'Arritmia', date: '22/05/2021'),
  ];

  getHeartRateHistory() async {
    await heartRateService.getData();
    if (mounted)
      setState(() {
        _heartRateHistoryList =
            heartRateService.hrHistoryList.reversed.toList();
        historyLoaded = true;
      });
  }

  @override
  void initState() {
    super.initState();
    getHeartRateHistory();
  }

  @override
  void dispose() {
    historyLoaded = false;
    _heartRateHistoryList.clear();
    super.dispose();
  }

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
          ? !historyLoaded
              ? Center(child: CircularProgressIndicator())
              : HeartRateListView(heartRateHistoryList: _heartRateHistoryList)
          : AlertListView(alertHistoryList: _alertHistoryList),
      floatingActionButton: FloatingActionButton(
        child: _showHeartRate
            ? Icon(Icons.priority_high)
            : Icon(Icons.favorite_border),
        onPressed: () {
          setState(() {
            _showHeartRate = !_showHeartRate;
          });
        },
      ),
    );
  }
}
