import 'package:flutter/material.dart';

Widget closeAppDialog(BuildContext context) {
  return AlertDialog(
    title: new Text(
      'Do you want to exit this application?',
      style: Theme.of(context).textTheme.bodyText1,
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: new Text('No'),
      ),
      new FlatButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: new Text('Yes'),
      ),
    ],
  );
}
