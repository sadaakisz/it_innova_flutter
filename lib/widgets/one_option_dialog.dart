import 'package:flutter/material.dart';

Future oneOptionDialog(
    {required BuildContext context,
    required String title,
    required String content,
    String action = 'Volver a intentar',
    VoidCallback? onDismiss}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onDismiss != null) onDismiss();
              },
              child: Text(action)),
        ),
      ],
    ),
  );
}
