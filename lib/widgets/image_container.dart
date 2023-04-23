import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final dynamic imageSource;
  final double borderRadius;

  const ImageContainer({required this.imageSource, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (imageSource is Uint8List) {
      imageWidget = Image.memory(
        imageSource,
        fit: BoxFit.cover,
      );
    } else if (imageSource is File) {
      imageWidget = Image.file(
        imageSource,
        fit: BoxFit.cover,
      );
    } else {
      throw ArgumentError('Unsupported image source type: $imageSource');
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageWidget,
    );
  }
}
