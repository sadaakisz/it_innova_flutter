import 'package:flutter/material.dart';

Future oneOptionDialog(
    {required BuildContext context,
    required String title,
    required String content,
    String action = 'Volver a intentar'}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(action)),
        ),
      ],
    ),
  );
}
