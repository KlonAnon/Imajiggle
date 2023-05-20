import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gallery_model.dart';

import '../widgets/delete_confirmation.dart';

class FullScreenImage extends StatelessWidget {
  final dynamic imageSource;

  const FullScreenImage({required this.imageSource});

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (imageSource is Uint8List) {
      imageWidget = Image.memory(
        imageSource,
        fit: BoxFit.contain,
      );
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
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteConfirmation();
                      },
                    ).then((value) {
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
      body: SizedBox.expand(
        child: imageWidget,
      ),
      backgroundColor: Colors.black,
    );
  }
}
