import 'package:flutter/material.dart';

showErrorAlertDialog(String message, context) {
  showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Okay"),
            )
          ],
        );
      });
}
