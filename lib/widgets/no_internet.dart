import 'package:flutter/material.dart';

// Widget for showing a No-Internet-Dialog
class NoInternetDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning, color: Color.fromARGB(255, 235, 215, 42)),
          SizedBox(width: 8.0),
          Text('No Internet Connection'),
        ],
      ),
      content: Text('Please check your internet connection and try again.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
