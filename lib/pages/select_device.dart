import 'package:flutter/material.dart';
import 'package:it_innova_flutter/widgets/one_option_dialog.dart';
import 'package:it_innova_flutter/widgets/two_options_dialog.dart';

class SelectDevice extends StatefulWidget {
  const SelectDevice({Key? key}) : super(key: key);

  @override
  _SelectDeviceState createState() => _SelectDeviceState();
}

class _SelectDeviceState extends State<SelectDevice> {
  void _showConnectedDevice(String deviceName) {
    oneOptionDialog(
      context: context,
      title: '¡Wearable Conectado!',
      content: 'Se conectó a $deviceName satisfactoriamente!',
      action: 'Ir a ver mi ritmo cardíaco',
      onDismiss: () => _onConnected(),
    );
  }

  void _onConnected() {
    Navigator.of(context).pop();
  }

  final List<String> _devicesList = ['Amazfit Bip Lite', 'Mi Band Xiaomi'];
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
      body: ListView.separated(
        itemCount: _devicesList.length,
        itemBuilder: (BuildContext context, int index) {
          var deviceItem = _devicesList[index];
          return ListTile(
            title: Text(deviceItem),
            trailing: Icon(Icons.link),
            onTap: () {
              twoOptionsDialog(
                context: context,
                title: '¿Estás seguro de conectarse al dispositivo elegido?',
                action: () => _showConnectedDevice(deviceItem),
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 5);
        },
      ),
    );
  }
}
