import 'package:flutter/material.dart';
import 'package:it_innova_flutter/widgets/heart_rate_indicator.dart';

class HeartRate extends StatefulWidget {
  const HeartRate({Key? key}) : super(key: key);

  @override
  _HeartRateState createState() => _HeartRateState();
}

class _HeartRateState extends State<HeartRate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ritmo cardiaco',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
        child: HeartRateIndicator(bpm: 89),
      ),
    );
  }
}
