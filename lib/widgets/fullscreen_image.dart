import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gallery_model.dart';

import '../widgets/delete_confirmation.dart';

// Widget for displaying an image in fullscreen
// notice how BoxFit.contain is used to fit the smaller side of its space without stretching or overlapping its borders
class FullScreenImage extends StatelessWidget {
  final dynamic imageSource;

  const FullScreenImage({required this.imageSource});

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    // if the imageSource is a generated picture (Uint8List) use the Image.memory widget for display
    if (imageSource is Uint8List) {
      imageWidget = Image.memory(
        imageSource,
        fit: BoxFit.contain,
      );
      // if the imageSource is stored on the device (File object) use the Image.file widget for display
      // and add a share and delete option (with icons) at the bottom
    } else if (imageSource is File) {
      imageWidget = Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            imageSource,
            fit: BoxFit.contain,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    // Share image logic goes here
                  },
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // show delete confirmation
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteConfirmation();
                      },
                    ).then((value) {
                      // if delete got clicked delete the image and go back to the gallery / caller
                      if (value != null && value is bool && value) {
                        final galleryModel = Provider.of<GalleryModel>(context, listen: false);
                        galleryModel.deleteImage(imageSource);
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      throw ArgumentError('Unsupported image source type: $imageSource');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      // reserve as much space as possible for image display
      body: SizedBox.expand(
        child: imageWidget,
      ),
      backgroundColor: Colors.black,
    );
  }
}
