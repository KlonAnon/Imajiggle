import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../widgets/error_msg.dart';

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
