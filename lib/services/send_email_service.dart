import 'dart:convert';

import 'package:http/http.dart';

class SendEmailService {
  Future<Response> sendEmail({required String email}) async {
    print(email);
    final body = {'email': email};
    Response response = await post(
      Uri.parse('http://40.76.250.197:8080/forgot_password_app'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print(response.statusCode);
    return response;
  }
}
