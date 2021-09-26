import 'package:flutter/material.dart';
import 'package:it_innova_flutter/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeSharedPrefsVariables();
  runApp(MyApp());
}

_initializeSharedPrefsVariables() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('bpm')) await prefs.setInt('bpm', 0);
  if (!prefs.containsKey('bpmTime')) await prefs.setString('bpmTime', '');
  if (!prefs.containsKey('enabledLocation'))
    await prefs.setBool('enabledLocation', false);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IT Innova',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.cyan.shade100,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.cyan.shade100,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueGrey.shade800)),
        ),
      ),
      //home: Home(),
      home: Login(),
    );
  }
}
