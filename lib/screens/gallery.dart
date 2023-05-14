import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/image_container.dart';
import '../widgets/error_msg.dart';
import '../models/gallery_model.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(12),
      child: Consumer<GalleryModel>(
        builder: (context, galleryModel, _) {
          if (galleryModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (galleryModel.hasError) {
            return ErrorMsg(errorIcon: Icons.error, errorMsg: 'Error loading images');
          } else if (galleryModel.imageFiles.isEmpty) {
            return ErrorMsg(errorIcon: Icons.image_not_supported, errorMsg: 'No liked images yet');
          } else {
            return GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: (width / 150).round(),
              children: galleryModel.imageFiles
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
