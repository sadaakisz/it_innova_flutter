import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class RegisterService {
  Future<Response> registerClient(String name, String surname, String email,
      String password, String dni) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    String now = dateFormat.format(DateTime.now()) + '.000+00:00';
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
