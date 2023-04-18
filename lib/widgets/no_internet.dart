import 'package:flutter/material.dart';

class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: [
        Icon(Icons.warning, color: Colors.yellow),
        SizedBox(width: 8.0),
        Text('No Internet Connection')
      ]),
      content: Text('Please check your internet connection and try again.'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'))
      ],
    );
  }
}
