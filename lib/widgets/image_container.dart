import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import './fullscreen_image.dart';

// Widget for displaying an image in memory or storage with round edges + gesture to tap into fullscreen mode
// notice how BoxFit.cover is used to make sure the image definitely fills out its space without being stretched
class ImageContainer extends StatelessWidget {
  final dynamic imageSource;
  final double borderRadius; // represents how round the edges should be

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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => FullScreenImage(imageSource: imageSource)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: imageWidget,
      ),
    );
  }
}
