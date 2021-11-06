import 'dart:convert';

import 'package:http/http.dart';
import 'package:it_innova_flutter/models/patient_info.dart';

class PatientInfoService {
  late PatientInfo patientInfo;
  Future<Response> modifyData() async {
    final body = patientInfo.toJson();
    Response response = await post(
      Uri.parse('http://40.76.250.197:8080/change_datax'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print(response.statusCode);
    return response;
  }
}
