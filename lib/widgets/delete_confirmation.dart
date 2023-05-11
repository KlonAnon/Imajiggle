import 'dart:io';

import 'package:flutter/material.dart';

class DeleteConfirmation extends StatelessWidget {
  final File imageFile;

  const DeleteConfirmation({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Image?'),
      content: Text('Are you sure you want to delete this image?'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop();
            imageFile.delete();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
