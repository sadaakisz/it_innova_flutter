import 'package:flutter/material.dart';

Future twoOptionsDialog({
  required BuildContext context,
  required String title,
  String accept = 'Aceptar',
  required VoidCallback action,
  String cancel = 'Cancelar',
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              action();
            },
            child: Text(accept),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(cancel)),
        ),
      ],
    ),
  );
}
