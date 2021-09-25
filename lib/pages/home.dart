import 'package:flutter/material.dart';
import 'package:it_innova_flutter/pages/heart_rate.dart';
import 'package:it_innova_flutter/pages/history.dart';
import 'package:it_innova_flutter/pages/profile.dart';
import 'package:it_innova_flutter/pages/settings.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _buildScreens() {
    return [
      HeartRate(),
      History(),
      Profile(),
      Settings(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite),
        title: ("Ritmo Cardiaco"),
        activeColorPrimary: Colors.black87,
        inactiveColorPrimary: Colors.black87,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.list),
        title: ("Historial"),
        activeColorPrimary: Colors.black87,
        inactiveColorPrimary: Colors.black87,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Perfil"),
        activeColorPrimary: Colors.black87,
        inactiveColorPrimary: Colors.black87,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Configuración"),
        activeColorPrimary: Colors.black87,
        inactiveColorPrimary: Colors.black87,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
