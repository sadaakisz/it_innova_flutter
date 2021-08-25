import 'package:flutter/material.dart';
import 'package:it_innova_flutter/pages/home.dart';

void main() {
  runApp(MyApp());
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
          //elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueGrey.shade800)),
        ),
      ),
      home: Home(),
    );
  }
}
