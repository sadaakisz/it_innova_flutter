import 'dart:convert';

import 'package:http/http.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';
import 'package:it_innova_flutter/util/json_time.dart';
import 'package:it_innova_flutter/util/patient_id.dart';

class HeartRateService {
  List<HeartRateHistory> hrHistoryList = [];
  late HeartRateHistory heartRateHistory;
  Future<Response> createData() async {
    final patientId = await PatientId().getId();
    final body = heartRateHistory.toJson();
    Response response = await post(
      Uri.parse(
          'http://40.76.250.197:8080/ritmo/mobile/$patientId/RitmoCardiaco'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print(response.statusCode);
    return response;
  }

  Future<void> getData() async {
    hrHistoryList.clear();
    Response response = await get(
      Uri.parse('http://40.76.250.197:8080/ritmo/mobile/12/RitmoCardiaco'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    Map data = jsonDecode(utf8.decode(response.bodyBytes));
    for (var i = 0; i < data['numberOfElements']; i++) {
      HeartRateHistory heartRateItem =
          new HeartRateHistory.fromJson(data['content'][i]);
      heartRateItem.date = JsonTime().fromJsonToStringTime(heartRateItem.date);
      hrHistoryList.add(heartRateItem);
    }
    print(response.statusCode);
  }
}
