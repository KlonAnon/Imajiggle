import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final IconData errorIcon;
  final String errorMsg;

  const ErrorMsg({required this.errorIcon, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            errorIcon,
            color: Colors.grey[600],
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            errorMsg,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
