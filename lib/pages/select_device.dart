import 'package:flutter/material.dart';

class SelectDevice extends StatefulWidget {
  const SelectDevice({Key? key}) : super(key: key);

  @override
  _SelectDeviceState createState() => _SelectDeviceState();
}

class _SelectDeviceState extends State<SelectDevice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elegir dispositivo',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
    );
  }
}
