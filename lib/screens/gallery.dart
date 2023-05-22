import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gallery_model.dart';

import '../widgets/image_container.dart';
import '../widgets/error_msg.dart';

// Widget implements the gallery for displaying all liked images
class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(12),
      // use the gallery model, which holds necessary variables / states
      child: Consumer<GalleryModel>(
        builder: (context, galleryModel, _) {
          // handle all possible scenarios (errors, loading...)
          if (galleryModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (galleryModel.hasError) {
            return ErrorMsg(errorIcon: Icons.error, errorMsg: 'Error loading images');
          } else if (galleryModel.imageFiles.isEmpty) {
            return ErrorMsg(errorIcon: Icons.image_not_supported, errorMsg: 'No liked images yet');
          } else {
            // using GridView.builder to only call the builder of children that are actually visible
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: (width / 150).round(), // make the number of images in a row dependent the widgets width
              ),
              itemCount: galleryModel.imageFiles.length,
              itemBuilder: (context, index) {
                final imageFile = galleryModel.imageFiles[index];
                return ImageContainer(
                  imageSource: imageFile,
                  borderRadius: 5,
                );
              },
            );
          }
        },
      ),
    );
  }
}
