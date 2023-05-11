import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/image_container.dart';
import '../utils/image_operations.dart';
import '../widgets/error_msg.dart';

class Gallery extends StatefulWidget {
  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  late Future<List<File>> _imageFiles;

  @override
  void initState() {
    super.initState();
    _imageFiles = getImagesFromDirectory();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(12),
      child: FutureBuilder<List<File>>(
        future: _imageFiles,
        builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
          // Display a loading indicator while waiting for the images to load
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
            // Handle any error that occurred while loading the images
          } else if (snapshot.hasError) {
            return ErrorMsg(errorIcon: Icons.error, errorMsg: 'Error loading images');
            // Handle the case when there are no images
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return ErrorMsg(errorIcon: Icons.image_not_supported, errorMsg: 'No liked images yet');
            // Display the GridView with the loaded images
          } else {
            List<File> imageFiles = snapshot.data!;
            return GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: (width / 150).round(),
              children: imageFiles
                  .map(
                    (file) => ImageContainer(
                      imageSource: file,
                      borderRadius: 5,
                    ),
                  )
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
