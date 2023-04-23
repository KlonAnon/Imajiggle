import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/image_container.dart';
import '../utils/image_operations.dart';

class Gallery extends StatefulWidget {
  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<File> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    (() async {
      List<File> imageFiles = await getImagesFromDirectory();
      setState(() {
        _imageFiles = imageFiles;
      });
    })();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      children: _imageFiles
          .map(
            (file) => ImageContainer(
              imageSource: file,
              borderRadius: 5,
            ),
          )
          .toList(),
    );
  }
}
