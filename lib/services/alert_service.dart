import 'dart:convert';

import 'package:http/http.dart';
import 'package:it_innova_flutter/models/alert_history.dart';
import 'package:it_innova_flutter/util/json_time.dart';
import 'package:it_innova_flutter/util/patient_id.dart';

class AlertService {
  List<AlertHistory> alertHistoryList = [];
  Future<void> getData() async {
    final patientId = await PatientId().getId();
    alertHistoryList.clear();
    Response response = await get(
      Uri.parse(
          'http://40.76.250.197:8080/emergencia/mobile/$patientId/Emergency'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    Map data = jsonDecode(utf8.decode(response.bodyBytes));
    for (var i = 0; i < data['numberOfElements']; i++) {
      AlertHistory alertItem = new AlertHistory.fromJson(data['content'][i]);
      alertItem.date = JsonTime().fromJsonToStringTime(alertItem.date);
      alertHistoryList.add(alertItem);
    }
    print(response.statusCode);
  }
}
