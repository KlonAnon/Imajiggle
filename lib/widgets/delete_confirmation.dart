import 'package:flutter/material.dart';

// Widget for showing a delete confirmation dialog
// the dialog returns true to its caller when delete was clicked and false if cancel was called
class DeleteConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Image?'),
      content: Text('Are you sure you want to delete this image?'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
