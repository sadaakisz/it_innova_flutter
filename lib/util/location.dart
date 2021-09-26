import 'package:location/location.dart';

class AppLocation {
  Future<String> getLatitude() async {
    Location location = new Location();
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return '';
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return '';
      }
    }

    _locationData = await location.getLocation();
    String _latitude = _locationData.latitude!.toString();

    return _latitude;
  }

  Future<String> getLongitude() async {
    Location location = new Location();
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return '';
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return '';
      }
    }

    _locationData = await location.getLocation();
    String _longitude = _locationData.longitude!.toString();

    return _longitude;
  }
}
