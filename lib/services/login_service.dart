import 'dart:convert';

import 'package:http/http.dart';

class LoginService {
  late int patientId;
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
    patientId = int.parse(data['Id']);
    print(response.statusCode);
    return response;
  }
}
