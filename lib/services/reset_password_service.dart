import 'dart:convert';

import 'package:http/http.dart';

class ResetPasswordService {
  Future<Response> resetPassword({
    required String email,
    required String token,
    required String password,
  }) async {
    print(email);
    print(token);
    print(password);
    final body = {
      'email': email,
      'token': token,
      'password': password,
    };
    Response response = await post(
      Uri.parse('http://40.76.250.197:8080/reset_password_app'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print(response.statusCode);
    return response;
  }
}
