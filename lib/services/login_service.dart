import 'dart:convert';

import 'package:http/http.dart';

class LoginService {
  late int patientId;
  late String patientName;
  late String patientLastName;
  late String patientEmail;
  late String patientPassword;
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final body = {
      'email': email,
      'password': password,
    };
    Response response = await post(
      Uri.parse('http://40.76.250.197:8080/login_app'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    Map data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      patientId = int.parse(data['Id']);
      patientName = data['name'];
      patientLastName = data['lastName'];
      patientEmail = data['email'];
      patientPassword = data['password'];
    }
    print(response.statusCode);
    return response;
  }
}
