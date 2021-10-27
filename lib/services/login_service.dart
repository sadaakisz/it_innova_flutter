import 'dart:convert';

import 'package:http/http.dart';

class LoginService {
  Future<Response> login({required String email, password}) async {
    print(email);
    print(password);
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
    print(response.statusCode);
    return response;
  }
}
