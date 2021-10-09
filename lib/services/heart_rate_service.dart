import 'dart:convert';

import 'package:http/http.dart';
import 'package:it_innova_flutter/models/heart_rate_history.dart';

class HeartRateService {
  late HeartRateHistory heartRateHistory;
  Future<void> createData() async {
    final body = heartRateHistory.toJson();
    try {
      Response response = await post(
        Uri.parse('http://40.76.250.197:8080/ritmo/mobile/12/RitmoCardiaco'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      print(response.statusCode);
    } catch (e) {
      print('Caught error $e');
    }
  }
}
