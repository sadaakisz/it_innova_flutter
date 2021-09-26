import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:it_innova_flutter/util/json_time.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';
import 'package:it_innova_flutter/widgets/two_options_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDevice extends StatefulWidget {
  SelectDevice({Key? key}) : super(key: key);
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList =
      new List<BluetoothDevice>.empty(growable: true);
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();

  @override
  _SelectDeviceState createState() => _SelectDeviceState();
}

class _SelectDeviceState extends State<SelectDevice> {
  late SharedPreferences prefs;
  Future<bool>? sharedPrefsLoaded;

  Future<bool> _initializeSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  setBpmPrefs(value) async {
    prefs = await SharedPreferences.getInstance();
    if (value != null) {
      await prefs.setInt('bpm', value);
      await prefs.setString('bpmTime', JsonTime().getJsonTime());
    }
  }

  void _showConnectedDevice(String deviceName, BluetoothDevice device) {
    oneOptionDialog(
      context: context,
      title: '¡Wearable Conectado!',
      content: 'Se conectó a $deviceName satisfactoriamente!',
      action: 'Ir a ver mi ritmo cardíaco',
      onDismiss: () {
        _onConnected();
        _connectDevice(device).whenComplete(() {
          for (BluetoothService service in _services) {
            if (service.uuid.toString() ==
                '0000180d-0000-1000-8000-00805f9b34fb') {
              _notifyValue(service.characteristics[0])
                  .whenComplete(() => _readValue(service.characteristics[1]));
              service.characteristics[0].value.listen((value) {
                if (value.length > 1) {
                  if (value[1] != 0) setBpmPrefs(value[1]);
                }
              });
            }
          }
        });
      },
    );
  }

  void _onConnected() {
    Navigator.of(context).pop();
  }

  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services =
      List<BluetoothService>.empty(growable: true);
  _addDeviceToList(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      if (mounted) {
        setState(() {
          widget.devicesList.add(device);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceToList(device);
      }
    });
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        _addDeviceToList(result.device);
      }
    });
    widget.flutterBlue.startScan();
    sharedPrefsLoaded = _initializeSharedPrefs();
  }

  _connectDevice(device) async {
    widget.flutterBlue.stopScan();
    try {
      await device.connect();
    } catch (e) {
      print(e);
    } finally {
      _services = await device.discoverServices();
      //print(_services);
    }
    if (mounted) {
      setState(() {
        _connectedDevice = device;
      });
    }
  }

  ListView _buildListViewOfDevices() {
    List<Widget> tiles = new List<Widget>.empty(growable: true);
    int index = 0;
    for (BluetoothDevice device in widget.devicesList) {
      String name = device.name == '' ? '(unknown device)' : device.name;
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            title: Text(name),
            trailing: Icon(Icons.link),
            onTap: () {
              twoOptionsDialog(
                context: context,
                title: '¿Estás seguro de conectarse al dispositivo elegido?',
                action: () => _showConnectedDevice(name, device),
              );
            },
          ),
        ),
      );
      index++;
      if (index != widget.devicesList.length) {
        tiles.add(Container(
          height: 2,
          color: Colors.black12,
        ));
      }
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...tiles,
      ],
    );
  }

  _readValue(characteristic) async {
    //00002a39-0000-1000-8000-00805f9b34fb
    var sub = characteristic.value.listen((value) {
      if (mounted) {
        setState(() {
          widget.readValues[characteristic.uuid] = value;
        });
      }
    });
    await characteristic.read();
    sub.cancel();
  }

  _notifyValue(characteristic) async {
    //00002a37-0000-1000-8000-00805f9b34fb
    characteristic.value.listen((value) {
      widget.readValues[characteristic.uuid] = value;
    });
    await characteristic.setNotifyValue(true);
  }

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
      body: _buildListViewOfDevices(),
    );
  }
}
