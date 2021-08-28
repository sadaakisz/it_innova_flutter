import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _locationActivated = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ubicación',
          style: TextStyle(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: ListTile(
        title: Text('Activar Ubicación'),
        trailing: Switch(
          value: _locationActivated,
          onChanged: (bool value) {
            setState(() {
              _locationActivated = !_locationActivated;
            });
          },
        ),
      ),
    );
  }
}
