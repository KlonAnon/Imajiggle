import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.mail),
              hintText: 'Email',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              hintText: 'Password',
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 200, height: 50),
          child: ElevatedButton(
            onPressed: () {
              print('login');
            },
            child: Text('Login'),
          ),
        ),
      ],
    );
  }
}
