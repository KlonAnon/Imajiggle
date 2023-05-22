import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../widgets/error_msg.dart';

// Widget for displaying the History-Screen
// the logic of this screen is not implemented yet, for implementation a HistoryModel will be needed!
class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Uint8List> images = [];

    return Visibility(
      visible: images.isNotEmpty,
      replacement: ErrorMsg(errorIcon: Icons.watch_later, errorMsg: 'No history yet'),
      child: Text('Not implemented yet'),
    );
  }
}
