import 'package:flutter/material.dart';
import 'dart:typed_data';

class ImageContainer extends StatelessWidget {
  final Uint8List imageBytes;
  final double width;
  final double height;

  const ImageContainer({
    required this.imageBytes,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.memory(
          imageBytes,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
