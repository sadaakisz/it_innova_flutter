import 'package:flutter/material.dart';
import 'package:it_innova_flutter/pages/heart_rate.dart';
import 'package:it_innova_flutter/pages/history.dart';
import 'package:it_innova_flutter/pages/profile.dart';
import 'package:it_innova_flutter/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<String> _pageTitles = <String>[
    'Ritmo Cardiaco',
    'Historial Ritmo Cardiaco',
    'Mi Perfil',
    'Ubicación'
  ];
  static List<Widget> _widgetOptions = <Widget>[
    //WearableList(),
    HeartRate(),
    History(),
    Profile(),
    Settings(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.black87, fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        unselectedItemColor: Colors.black87,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Ritmo Cardiaco'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configuración'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
