import 'dart:async';

import 'package:flutter/material.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';
import 'package:it_innova_flutter/pages/select_device.dart';
import 'package:it_innova_flutter/services/heart_rate_service.dart';
import 'package:it_innova_flutter/util/json_time.dart';
import 'package:it_innova_flutter/widgets/heart_rate_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartRate extends StatefulWidget {
  const HeartRate({Key? key}) : super(key: key);

  @override
  _HeartRateState createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  Timer? timer;
  int bpm = 0;

  HeartRateService service = new HeartRateService();

  void createData() async {
    String now = JsonTime().getJsonTime();
    HeartRateHistory heartRateHistory =
        new HeartRateHistory(bpm: bpm, date: now);
    service.heartRateHistory = heartRateHistory;
    await service.createData();
  }

  _getBpm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (bpm != prefs.getInt('bpm')) {
      setState(() {
        bpm = prefs.getInt('bpm')!;
      });
      createData();
    }
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => _getBpm());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
            HeartRateIndicator(bpm: bpm),
            SizedBox(height: width * 0.2),
            /*HeartRateChart(
              data: _heartRateHistoryList,
            ),*/
            Container(
              padding: EdgeInsets.symmetric(horizontal: width / 10),
              height: width / 5,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => SelectDevice()),
                    );
                  },
                  child: Text('Evaluar Ritmo Cardíaco')),
            ),
          ],
        ),
      ),
    );
  }
}
