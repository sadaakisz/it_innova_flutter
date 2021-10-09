import 'dart:convert';

import 'package:http/http.dart';
import 'package:it_innova_flutter/models/location_value.dart';

class LocationService {
  late LocationValue locationValue;
  Future<void> createData() async {
    final body = locationValue.toJson();
    try {
      Response response = await post(
        Uri.parse('http://40.76.250.197:8080/ubicacion/mobile/12/ubicacion'),
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
