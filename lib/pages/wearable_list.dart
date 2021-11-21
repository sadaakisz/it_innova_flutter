import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class WearableList extends StatefulWidget {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList =
      new List<BluetoothDevice>.empty(growable: true);
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();
  WearableList({Key? key}) : super(key: key);

  @override
  _WearableListState createState() => _WearableListState();
}

class _WearableListState extends State<WearableList> {
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services =
      List<BluetoothService>.empty(growable: true);
  _addDeviceToList(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
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
  }

  _connectDevice(device) async {
    widget.flutterBlue.stopScan();
    try {
      await device.connect();
    } catch (e) {
      print(e);
    } finally {
      _services = await device.discoverServices();
      print(_services);
    }
    setState(() {
      _connectedDevice = device;
    });
  }

  ListView _buildListViewOfDevices() {
    List<Container> containers = new List<Container>.empty(growable: true);
    for (BluetoothDevice device in widget.devicesList) {
      containers.add(Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(device.name == '' ? '(unknown device)' : device.name),
                  Text(device.id.toString()),
                ],
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: Text(
                'Connect',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _connectDevice(device);
              },
            ),
          ],
        ),
      ));
    }
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  ListView _buildConnectDeviceView() {
    List<Container> containers = new List<Container>.empty(growable: true);
    for (BluetoothService service in _services) {
      List<Widget> characteristicsWidget =
          new List<Widget>.empty(growable: true);
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        characteristic.value.listen((value) {
          print(value);
        });
        characteristicsWidget.add(
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(characteristic.uuid.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    ..._buildReadWriteNotifyButton(characteristic),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('Value: ' +
                        widget.readValues[characteristic.uuid].toString()),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        );
      }
      containers.add(
        Container(
          child: ExpansionTile(
              title: Text(service.uuid.toString()),
              children: characteristicsWidget),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }

  _readValue(characteristic) async {
    var sub = characteristic.value.listen((value) {
      setState(() {
        widget.readValues[characteristic.uuid] = value;
      });
    });
    await characteristic.read();
    sub.cancel();
  }

  _notifyValue(characteristic) async {
    characteristic.value.listen((value) {
      widget.readValues[characteristic.uuid] = value;
    });
    await characteristic.setNotifyValue(true);
  }

  List<ButtonTheme> _buildReadWriteNotifyButton(
      BluetoothCharacteristic characteristic) {
    List<ButtonTheme> buttons = new List<ButtonTheme>.empty(growable: true);

    if (characteristic.properties.read) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
              child: Text('READ', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _readValue(characteristic);
              },
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.write) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              child: Text('WRITE', style: TextStyle(color: Colors.white)),
              onPressed: () {},
            ),
          ),
        ),
      );
    }
    if (characteristic.properties.notify) {
      buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
              onPressed: () {
                _notifyValue(characteristic);
              },
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  ListView _buildView() {
    if (_connectedDevice != null) {
      return _buildConnectDeviceView();
    }
    return _buildListViewOfDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(),
    );
  }
}
