import 'dart:convert';

import 'package:http/http.dart';
import 'package:it_innova_flutter/models/location_value.dart';
import 'package:it_innova_flutter/util/patient_id.dart';

class LocationService {
  late LocationValue locationValue;
  Future<Response> createData() async {
    final patientId = await PatientId().getId();
    final body = locationValue.toJson();
    Response response = await post(
      Uri.parse(
          'http://40.76.250.197:8080/ubicacion/mobile/$patientId/ubicacion'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print(response.statusCode);
    return response;
  }
}
