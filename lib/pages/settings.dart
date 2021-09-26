import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _locationActivated = false;

  _getLocationEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _locationActivated = prefs.getBool('enabledLocation')!;
    });
  }

  _setLocationEnabled(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enabledLocation', value);
  }

  @override
  void initState() {
    _getLocationEnabled();
    super.initState();
  }

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
              _setLocationEnabled(_locationActivated);
            });
          },
        ),
      ),
    );
  }
}
