import 'dart:convert';

import 'package:http/http.dart';
import 'package:it_innova_flutter/util/json_time.dart';

class RegisterService {
  Future<Response> registerClient(String name, String surname, String email,
      String password, String dni) async {
    String now = JsonTime().getJsonTime();
    Response userResponse = await post(
      Uri.parse('http://40.119.40.228:8080/api/mobile/create'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'lastName': surname,
        'email': email,
        'password': password,
        'dni': dni,
        'dateCreation': now,
        'dateLocation': now
      }),
    );
    print(userResponse.statusCode);
    return userResponse;
  }
}
